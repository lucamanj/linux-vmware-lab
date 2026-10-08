# Disk Space Troubleshooting Lab

## Objective

Practice investigating disk space usage on a Linux system and identifying directories and files responsible for high disk usage.

## Environment

- Ubuntu 24.04.1 LTS
- WSL2
- User: `luca`

## Initial Disk Usage Check

The filesystem usage was checked with:

    df -h

The main Linux filesystem showed:

    /dev/sdd   251G   2.0G   237G   1%   /

The Linux filesystem was therefore not close to being full.

The Windows filesystem mounted at `/mnt/c` showed higher usage, but it was not considered part of the Linux filesystem investigation.

## Directory Usage Investigation

The main directories under `/` were analyzed with:

    sudo du -xh --max-depth=1 / 2>/dev/null | sort -hr

The main results were:

    2.0G    /
    1.2G    /usr
    789M    /var
    4.8M    /etc
    2.4M    /home

The `/var` directory was identified as one of the largest directories.

## Investigating /var

The contents of `/var` were analyzed with:

    sudo du -xh --max-depth=1 /var 2>/dev/null | sort -hr

The results showed:

    789M    /var
    418M    /var/log
    232M    /var/lib
    138M    /var/cache

The `/var/log` directory was therefore investigated further.

## Investigating /var/log

The contents of `/var/log` were analyzed with:

    sudo du -xh --max-depth=1 /var/log 2>/dev/null | sort -hr

The results showed:

    418M    /var/log
    414M    /var/log/journal

The systemd journal was identified as the main source of log disk usage.

## Journal Disk Usage

The journal disk usage was checked with:

    sudo journalctl --disk-usage

Result:

    Archived and active journals take up 413.4M in the file system.

The journal contained logs from multiple system boots.

The stored boots were checked with:

    sudo journalctl --list-boots

Five boots were listed in the journal.

## Warning Investigation

Recent warning-level messages were checked with:

    sudo journalctl -p warning -b --no-pager

The output contained several WSL and kernel-related warnings, as well as journal messages related to previous unclean shutdowns and journal rotation.

No logs were deleted during the investigation.

## Journal Files

The largest individual journal files were inspected with:

    sudo du -xh /var/log/journal/*/* 2>/dev/null | sort -hr | head -10

Several individual journal files were approximately 8 MB in size.

The total journal usage was significantly higher because multiple journal files were stored.

## Conclusion

The investigation showed that the Linux filesystem was not close to being full.

The main disk usage under `/var` was caused by systemd journal logs stored in:

    /var/log/journal

If the filesystem were actually running out of space, an appropriate next step would be to review the journal retention policy and remove or rotate older logs according to the system's requirements.

No log cleanup was performed during this lab.

## Commands Practiced

- `df -h`
- `du`
- `sort`
- `journalctl --disk-usage`
- `journalctl --list-boots`
- `journalctl -p warning`
- `head`
