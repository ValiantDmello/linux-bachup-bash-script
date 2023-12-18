# Backup Bash Script

## Overview

This Bash script, `backup.sh`, is designed to perform periodic backups on text files (\*.txt) found in the user's home directory. The script includes complete backups and incremental backups. Complete backups are made initially, and subsequent incremental backups only include new or modified files since the last complete or incremental backup.

## Usage

To run the script, use the following command:

```bash
./backup.sh
