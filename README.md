# Backup Bash Script

## Overview

This Bash script, `backup.sh`, is designed to perform periodic backups on text files (\*.txt) found in the user's home directory. The script includes complete backups and incremental backups. Complete backups are made initially, and subsequent incremental backups only include new or modified files since the last complete or incremental backup.

## Usage

To run the script, use the following command:

```bash
./backup.sh
```

### Options
-n: Run the script in the background.

### File Structure
The backup script organizes backups into two directories:

1. ~/backup/cb: Complete backups are stored here.
2. ~/backup/ib: Incremental backups are stored here.
3. The script also generates a log file at ~/backup/backup.log to track backup activities.

### Configuration
* cb_backup_no: Initial number for complete backups.
* ib_backup_no: Initial number for incremental backups.
* cb_backup_file: Naming convention for complete backups.
* ib_backup_file: Naming convention for incremental backups.

## Backup Process

Complete Backup: All text files (*.txt) found in /home/$USER are tarred and stored in the cb directory with a unique file name. The script logs the activity in backup.log.

Incremental Backup 1: Checks for new or modified files since the last complete backup. If there are changes, an incremental backup is created in the ib directory, and the log is updated.

Incremental Backup 2: Checks for new or modified files since the last incremental backup. If there are changes, a new incremental backup is created, and the log is updated.

Incremental Backup 3: Similar to Incremental Backup 2, creating a new backup if changes are detected.

## Log File

The log file, backup.log, records the date and details of each backup operation. It includes information on whether complete or incremental backups were created and if there were any changes detected.

## Running in the Background
The script allows running in the background using the -n option. For example:

```bash
./backup.sh -n
```
This makes the script run in the background, and the process is detached from the terminal.

Notes
The script uses a sleep duration of 120 seconds between each backup operation to avoid excessive resource usage.
Incremental backups are named sequentially based on the ib_backup_no variable.
Feel free to customize the script or configurations based on your specific backup requirements.
