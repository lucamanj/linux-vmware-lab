#!/bin/bash

BACKUP_DIR="$HOME/linux-vmware-lab/linux/automation/backups"
SOURCE_FILE="$HOME/linux-vmware-lab/linux/automation/server.log"
DATE=$(date +%Y-%m-%d)

mkdir -p "$BACKUP_DIR"

tar -czf "$BACKUP_DIR/server_log_$DATE.tar.gz" "$SOURCE_FILE"
