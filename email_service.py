"""Microsoft Graph email sender for the daily unpaid-procedure report.

Self-contained, mirrors the VetNotes-Sync EmailService (client-credentials
flow, /users/<from>/sendMail). Sends one HTML report email from + to the
accounts mailbox. The Graph app must have Mail.Send permission for the
REPORT_FROM_ADDRESS mailbox.
"""
from __future__ import annotations

from datetime import datetime, timedelta
from typing import Optional, Dict, Any

import msal
import requests

from config import config


class EmailService:
    GRAPH_BASE_URL = "https://graph.microsoft.com/v1.0"

    def __init__(self):
        self.tenant_id = config.GRAPH_TENANT_ID
        self.client_id = config.GRAPH_CLIENT_ID
        self.client_secret = config.GRAPH_CLIENT_SECRET
        self._access_token: Optional[str] = None
        self._token_expiry: Optional[datetime] = None

    def is_configured(self) -> bool:
        return config.is_email_configured()

    def _get_access_token(self) -> Optional[str]:
        if not all([self.tenant_id, self.client_id, self.client_secret]):
            print("Graph API credentials not configured")
            return None
        if self._access_token and self._token_expiry:
            if datetime.now() < self._token_expiry - timedelta(minutes=5):
                return self._access_token
        try:
            authority = f"https://login.microsoftonline.com/{self.tenant_id}"
            app = msal.ConfidentialClientApplication(
                self.client_id, authority=authority,
                client_credential=self.client_secret)
            result = app.acquire_token_for_client(
                scopes=["https://graph.microsoft.com/.default"])
            if "access_token" in result:
                self._access_token = result["access_token"]
                self._token_expiry = datetime.now() + timedelta(hours=1)
                return self._access_token
            print(f"Graph auth failed: {result.get('error_description', 'unknown')}")
            return None
        except Exception as e:
            print(f"Graph auth error: {e}")
            return None

    def send_report(self, subject: str, html_body: str,
                    to_address: str = None, from_address: str = None,
                    cc_addresses: str = None) -> Dict[str, Any]:
        """Send a single HTML report email via Graph sendMail."""
        if not self.is_configured():
            return {'success': False, 'error': 'Graph not configured'}
        token = self._get_access_token()
        if not token:
            return {'success': False, 'error': 'Failed to obtain access token'}

        to_address = to_address or config.REPORT_TO_ADDRESS
        from_address = from_address or config.REPORT_FROM_ADDRESS
        if cc_addresses is None:
            cc_addresses = config.REPORT_CC_ADDRESSES
        cc_list = [{"emailAddress": {"address": a.strip()}}
                   for a in (cc_addresses or '').split(',') if a.strip()]
        message = {
            "subject": subject,
            "body": {"contentType": "HTML", "content": html_body},
            "toRecipients": [{"emailAddress": {"address": to_address}}],
        }
        if cc_list:
            message["ccRecipients"] = cc_list
        payload = {"message": message, "saveToSentItems": True}
        url = f"{self.GRAPH_BASE_URL}/users/{from_address}/sendMail"
        try:
            resp = requests.post(
                url, headers={"Authorization": f"Bearer {token}",
                              "Content-Type": "application/json"},
                json=payload, timeout=30)
            if resp.status_code in (200, 201, 202, 204):
                return {'success': True}
            return {'success': False,
                    'error': f"Graph {resp.status_code}: {resp.text[:300]}"}
        except Exception as e:
            return {'success': False, 'error': str(e)}


_service: Optional[EmailService] = None


def get_email_service() -> EmailService:
    global _service
    if _service is None:
        _service = EmailService()
    return _service
