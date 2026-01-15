"""Configuration management for AI Accounts Assistant."""

import os
from pathlib import Path
from dotenv import load_dotenv

# Load environment variables
load_dotenv()


class Config:
    """Application configuration."""

    # Base paths
    BASE_DIR = Path(__file__).parent
    OUTPUT_FOLDER = BASE_DIR / 'output'
    PROMPTS_FOLDER = BASE_DIR / 'prompts'
    STATIC_FOLDER = BASE_DIR / 'static'
    TEMPLATES_FOLDER = BASE_DIR / 'templates'

    # Database
    DATABASE_PATH = BASE_DIR / 'accounts.db'

    # Claude API
    ANTHROPIC_API_KEY = os.getenv('ANTHROPIC_API_KEY')
    CLAUDE_MODEL = os.getenv('CLAUDE_MODEL', 'claude-sonnet-4-20250514')

    # Teleos MCP Server
    MCP_HOST = os.getenv('MCP_HOST', 'localhost')
    MCP_PORT = int(os.getenv('MCP_PORT', 3000))
    MCP_API_KEY = os.getenv('MCP_API_KEY', '')
    MCP_BASE_URL = f"http://{MCP_HOST}:{MCP_PORT}"

    # Flask
    FLASK_PORT = int(os.getenv('FLASK_PORT', 5003))
    SECRET_KEY = os.getenv('SECRET_KEY', 'dev-secret-key-change-in-production')

    # SSL
    SSL_CERT = BASE_DIR / 'certs' / 'server.crt'
    SSL_KEY = BASE_DIR / 'certs' / 'server.key'

    # CSV file location
    CSV_PATH = Path('/mnt/TELEVETLIVE/mdebtor.CSV')

    # Debt analysis settings
    MIN_BALANCE_THRESHOLD = 1.00  # Ignore balances under £1.00

    @classmethod
    def validate(cls) -> list:
        """Validate configuration and return list of errors."""
        errors = []

        if not cls.ANTHROPIC_API_KEY:
            errors.append("ANTHROPIC_API_KEY is required in .env")

        # Check CSV mount point exists
        csv_mount = cls.CSV_PATH.parent
        if not csv_mount.exists():
            errors.append(f"CSV mount point {csv_mount} does not exist")

        return errors

    @classmethod
    def ensure_directories(cls):
        """Create required directories if they don't exist."""
        cls.OUTPUT_FOLDER.mkdir(parents=True, exist_ok=True)


# Global config instance
config = Config()
