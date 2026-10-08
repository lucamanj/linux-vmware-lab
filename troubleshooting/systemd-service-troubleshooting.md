# Systemd Service Troubleshooting Lab

## Objective

Practice checking, starting, stopping and troubleshooting a systemd service.

## Environment

- Ubuntu 24.04.1 LTS
- WSL2
- User: `luca`
- Service: `myapp.service`

## Initial Status

The service was initially checked with:

    systemctl status myapp

Result:

    Active: inactive (dead)

The service was loaded correctly by systemd but was not running.

## Starting the Service

The service was started manually with:

    sudo systemctl start myapp

The status was then checked again:

    systemctl status myapp

Result:

    Active: active (running)

The service was running with a Bash process and a `sleep` process.

## Log Investigation

Service logs were checked with:

    sudo journalctl -u myapp --no-pager

The logs showed that systemd successfully started the service and did not report a startup failure.

## Service Configuration

The service configuration was inspected with:

    systemctl cat myapp

The service runs as the dedicated user:

    User=myapp

The command executed by the service continuously writes test data to:

    /var/lib/myapp/data.db

## File and Directory Permissions

The data file was checked with:

    sudo ls -l /var/lib/myapp/data.db

Result:

    -rw-r--r-- 1 myapp root

The file is owned by `myapp` and the owner has read and write permissions.

The parent directory was checked with:

    sudo ls -ld /var/lib/myapp

Result:

    drwxr-xr-x 2 root root

The directory is owned by `root:root` and the `myapp` user does not have write permission on the directory.

The existing data file could still be modified because it is owned by `myapp`.

## Verifying Service Activity

The size of `data.db` was checked twice while the service was running.

The file increased from:

    27840 bytes

to:

    27855 bytes

This confirmed that the service was actively writing to the data file.

## Service Control Tests

The service was stopped with:

    sudo systemctl stop myapp

The status was:

    inactive

The service was then restarted with:

    sudo systemctl restart myapp

The active state was verified with:

    systemctl is-active myapp

Result:

    active

Finally, the service was stopped again and verified as:

    inactive

## Commands Practiced

- `systemctl status`
- `systemctl start`
- `systemctl stop`
- `systemctl restart`
- `systemctl is-active`
- `systemctl cat`
- `journalctl`
- `ls -l`
- `ls -ld`
