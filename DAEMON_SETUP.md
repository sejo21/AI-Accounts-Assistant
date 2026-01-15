# Running AI Accounts Assistant as a Systemd Service

## Installation

1. **Copy the service file to systemd:**
   ```bash
   sudo cp /home/sejo/AI-Accounts-Assistant/ai-accounts-assistant.service /etc/systemd/system/
   ```

2. **Reload systemd to recognize the new service:**
   ```bash
   sudo systemctl daemon-reload
   ```

3. **Enable the service to start on boot:**
   ```bash
   sudo systemctl enable ai-accounts-assistant
   ```

4. **Start the service:**
   ```bash
   sudo systemctl start ai-accounts-assistant
   ```

## Management Commands

| Command | Description |
|---------|-------------|
| `sudo systemctl start ai-accounts-assistant` | Start the service |
| `sudo systemctl stop ai-accounts-assistant` | Stop the service |
| `sudo systemctl restart ai-accounts-assistant` | Restart the service |
| `sudo systemctl status ai-accounts-assistant` | Check service status |
| `sudo systemctl enable ai-accounts-assistant` | Enable start on boot |
| `sudo systemctl disable ai-accounts-assistant` | Disable start on boot |

## Viewing Logs

```bash
# View recent logs
sudo journalctl -u ai-accounts-assistant -n 50

# Follow logs in real-time
sudo journalctl -u ai-accounts-assistant -f

# View logs since last boot
sudo journalctl -u ai-accounts-assistant -b
```

## Quick Setup (All Commands)

```bash
# One-liner to install and start
sudo cp /home/sejo/AI-Accounts-Assistant/ai-accounts-assistant.service /etc/systemd/system/ && \
sudo systemctl daemon-reload && \
sudo systemctl enable ai-accounts-assistant && \
sudo systemctl start ai-accounts-assistant && \
sudo systemctl status ai-accounts-assistant
```
