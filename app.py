"""Flask web application for AI Accounts Assistant."""

import os
import threading
from datetime import datetime
from pathlib import Path
from flask import Flask, render_template, request, redirect, url_for, jsonify, send_file

from config import config
from csv_parser import load_debt_csv, DebtAccount
from debt_analyzer import DebtAnalyzer, CategorizationResult
from excel_generator import create_debt_excel
import database as db

# Ensure directories exist
config.ensure_directories()

app = Flask(__name__)
app.secret_key = config.SECRET_KEY

# Store analysis progress
analysis_progress = {}


@app.route('/')
def index():
    """Dashboard showing recent analysis runs."""
    runs = db.get_recent_runs(limit=20)
    return render_template('index.html', runs=runs)


@app.route('/new')
def new_analysis():
    """Start a new debt analysis."""
    # Check if CSV file exists
    csv_exists = config.CSV_PATH.exists()
    local_csv_exists = (Path(__file__).parent / 'mdebtor.csv').exists()

    return render_template(
        'new_analysis.html',
        csv_exists=csv_exists,
        local_csv_exists=local_csv_exists,
        csv_path=str(config.CSV_PATH)
    )


@app.route('/analyze', methods=['POST'])
def start_analysis():
    """Start the analysis process."""
    # Determine which CSV to use
    use_local = request.form.get('use_local', 'false') == 'true'

    if use_local:
        csv_path = Path(__file__).parent / 'mdebtor.csv'
    else:
        csv_path = config.CSV_PATH

    if not csv_path.exists():
        return jsonify({'error': f'CSV file not found: {csv_path}'}), 400

    # Check for test mode
    test_mode = request.form.get('test_mode') == 'on'
    account_limit = None
    if test_mode:
        try:
            account_limit = int(request.form.get('account_limit', 10))
        except ValueError:
            account_limit = 10

    # Create a new run
    run_id = db.create_run(str(csv_path))

    # Start analysis in background thread
    thread = threading.Thread(
        target=run_analysis,
        args=(run_id, csv_path, account_limit)
    )
    thread.start()

    return redirect(url_for('view_progress', run_id=run_id))


def run_analysis(run_id: int, csv_path: Path, account_limit: int = None):
    """Run the full analysis process (background thread)."""
    global analysis_progress

    try:
        # Update status
        db.update_run_status(run_id, 'processing')
        analysis_progress[run_id] = {
            'status': 'loading',
            'current': 0,
            'total': 0,
            'message': 'Loading CSV file...'
        }

        # Load CSV
        accounts = load_debt_csv(csv_path)

        # Apply account limit for test mode
        if account_limit and account_limit > 0:
            accounts = accounts[:account_limit]

        total = len(accounts)

        # Update totals
        total_value = sum(a.total_balance for a in accounts)
        db.update_run_totals(run_id, total, total_value)

        analysis_progress[run_id] = {
            'status': 'analyzing',
            'current': 0,
            'total': total,
            'message': f'Analyzing {total} accounts...'
        }

        # Add accounts to database
        account_ids = []
        for account in accounts:
            account_id = db.add_account(
                run_id=run_id,
                client_id=account.client_id,
                client_name=account.client_name,
                last_payment_amount=account.last_payment_amount,
                last_payment_date=account.last_payment_date.isoformat() if account.last_payment_date else None,
                current_balance=account.current,
                days_30=account.days_30,
                days_60=account.days_60,
                days_90=account.days_90,
                total_balance=account.total_balance
            )
            account_ids.append(account_id)

        # Run AI analysis
        analyzer = DebtAnalyzer()
        results = []

        def progress_callback(current, total, account):
            analysis_progress[run_id] = {
                'status': 'analyzing',
                'current': current,
                'total': total,
                'message': f'Analyzing {account.client_name}...'
            }

        for i, (account, account_id) in enumerate(zip(accounts, account_ids)):
            progress_callback(i + 1, total, account)

            result = analyzer.categorize_account(account)
            results.append(result)

            # Update database
            db.update_account_category(
                account_id=account_id,
                category=result.category,
                confidence=result.confidence,
                notes=result.notes,
                action_suggested=result.action_suggested,
                exclude_from_excel=result.exclude_from_excel
            )

        # Generate Excel
        analysis_progress[run_id] = {
            'status': 'generating',
            'current': total,
            'total': total,
            'message': 'Generating Excel file...'
        }

        timestamp = datetime.now().strftime('%Y-%m-%d_%H-%M-%S')
        excel_path = config.OUTPUT_FOLDER / f'debt_analysis_{timestamp}.xlsx'
        create_debt_excel(accounts, results, excel_path)

        # Update run status
        db.update_run_status(run_id, 'completed', str(excel_path))

        analysis_progress[run_id] = {
            'status': 'completed',
            'current': total,
            'total': total,
            'message': 'Analysis complete!'
        }

    except Exception as e:
        db.update_run_status(run_id, 'error')
        analysis_progress[run_id] = {
            'status': 'error',
            'current': 0,
            'total': 0,
            'message': f'Error: {str(e)}'
        }


@app.route('/progress/<int:run_id>')
def view_progress(run_id: int):
    """View analysis progress."""
    run = db.get_run(run_id)
    if not run:
        return redirect(url_for('index'))

    if run['status'] == 'completed':
        return redirect(url_for('view_results', run_id=run_id))

    return render_template('progress.html', run=run, run_id=run_id)


@app.route('/api/progress/<int:run_id>')
def get_progress(run_id: int):
    """API endpoint to get analysis progress."""
    progress = analysis_progress.get(run_id, {
        'status': 'unknown',
        'current': 0,
        'total': 0,
        'message': 'Unknown'
    })
    return jsonify(progress)


@app.route('/run/<int:run_id>')
def view_results(run_id: int):
    """View results of an analysis run."""
    run = db.get_run(run_id)
    if not run:
        return redirect(url_for('index'))

    accounts = db.get_accounts_by_run(run_id)
    summary = db.get_run_summary(run_id)

    return render_template(
        'results.html',
        run=run,
        accounts=accounts,
        summary=summary
    )


@app.route('/run/<int:run_id>/excel')
def download_excel(run_id: int):
    """Download the Excel file for a run."""
    run = db.get_run(run_id)
    if not run or not run['excel_path']:
        return redirect(url_for('view_results', run_id=run_id))

    excel_path = Path(run['excel_path'])
    if not excel_path.exists():
        return redirect(url_for('view_results', run_id=run_id))

    return send_file(
        excel_path,
        as_attachment=True,
        download_name=excel_path.name
    )


@app.route('/api/account/<int:account_id>/update', methods=['POST'])
def update_account(account_id: int):
    """Update an account's category manually."""
    data = request.get_json()
    category = data.get('category')
    notes = data.get('notes', '')

    if category not in ['MED', 'MED READY', 'PAY', 'PAID', 'INS', 'SMJ', 'STAFF', 'BAD', 'INV']:
        return jsonify({'error': 'Invalid category'}), 400

    db.update_account_manual(account_id, category, notes)

    # If marking as STAFF, also save to persistent staff_accounts table
    if category == 'STAFF':
        account = db.get_account(account_id)
        if account:
            db.mark_as_staff(account['client_id'], account['client_name'])

    return jsonify({'success': True})


@app.route('/api/account/<int:account_id>/unmark-staff', methods=['POST'])
def unmark_staff(account_id: int):
    """Remove staff designation from an account."""
    account = db.get_account(account_id)
    if account:
        # Remove from persistent staff table
        db.unmark_as_staff(account['client_id'])
        # Set category to SMJ for manual review
        db.update_account_manual(account_id, 'SMJ', 'Unmarked as staff - needs review')
    return jsonify({'success': True})


@app.route('/api/account/<int:account_id>/sms', methods=['POST'])
def mark_sms(account_id: int):
    """Mark that an SMS has been sent."""
    db.mark_sms_sent(account_id)
    return jsonify({'success': True})


@app.route('/api/account/<int:account_id>/email', methods=['POST'])
def mark_email(account_id: int):
    """Mark that an email has been sent."""
    db.mark_email_sent(account_id)
    return jsonify({'success': True})


@app.route('/run/<int:run_id>/delete', methods=['POST'])
def delete_run(run_id: int):
    """Delete a run and its data."""
    db.delete_run(run_id)
    return redirect(url_for('index'))


if __name__ == '__main__':
    # Check for SSL certificates
    ssl_context = None
    if config.SSL_CERT.exists() and config.SSL_KEY.exists():
        ssl_context = (str(config.SSL_CERT), str(config.SSL_KEY))

    app.run(
        host='0.0.0.0',
        port=config.FLASK_PORT,
        debug=True,
        ssl_context=ssl_context
    )
