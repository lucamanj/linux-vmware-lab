# Backup Automation Lab

## Scenario

A server generates log files that need to be backed up automatically.

The goal is to create a Bash script that creates a compressed backup and schedule it to run automatically using cron.

## 1. Create the backup script

The script was created at:

```text
linux/automation/backup.sh
```

Script:

```bash
#!/bin/bash

BACKUP_DIR="$HOME/linux-vmware-lab/linux/automation/backups"
SOURCE_FILE="$HOME/linux-vmware-lab/linux/automation/server.log"
DATE=$(date +%Y-%m-%d)

mkdir -p "$BACKUP_DIR"

tar -czf "$BACKUP_DIR/server_log_$DATE.tar.gz" "$SOURCE_FILE"
```

The script:

- defines the backup directory
- defines the source log file
- generates the current date
- creates the backup directory if necessary
- creates a compressed `.tar.gz` archive

## 2. Make the script executable

Command:

```bash
chmod +x linux/automation/backup.sh
```

## 3. Create the log file

Command:

```bash
echo "Linux & VMware Lab - test log" > linux/automation/server.log
```

## 4. Run the backup

Command:

```bash
./linux/automation/backup.sh
```

The script successfully created:

```text
server_log_2026-10-08.tar.gz
```

## 5. Verify the backup

Command:

```bash
ls -lh linux/automation/backups/
```

The backup file was present in the directory.

The archive contents were then verified with:

```bash
tar -tzf linux/automation/backups/server_log_2026-10-08.tar.gz
```

The archive contained:

```text
home/luca/linux-vmware-lab/linux/automation/server.log
```

## 6. Configure cron

A user crontab was created with:

```bash
crontab -e
```

The following entry was added:

```cron
0 2 * * * /home/luca/linux-vmware-lab/linux/automation/backup.sh
```

This configures the backup script to run every day at 02:00.

The configuration was verified with:

```bash
crontab -l
```

## 7. Verify cron service

Command:

```bash
systemctl status cron --no-pager
```

Result:

```text
Active: active (running)
```

The cron service is running correctly.

## Conclusion

The backup automation was successfully configured.

The Bash script creates compressed backups of the log file, while cron automatically executes the script every day at 02:00.

This demonstrates basic Linux task automation using Bash, `tar`, and cron.
