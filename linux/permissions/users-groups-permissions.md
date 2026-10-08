# Linux Users, Groups and Permissions Lab

## Objective

Practice Linux user and group management, sudo configuration and file permissions.

## Environment

- Ubuntu 24.04.1 LTS
- WSL2
- User: `luca`

## Users and Groups

Created the `andrea` user and added it to the `sysadmins` group.

Verified with:

    id andrea

Result:

    uid=1010(andrea) gid=1011(andrea) groups=1011(andrea),1006(sysadmins)

## Sudo Configuration

Configured the `sysadmins` group to have administrative privileges through `/etc/sudoers`.

Rule added:

    %sysadmins ALL=(ALL:ALL) ALL

Verified with:

    sudo -l -U andrea

Result:

    User andrea may run the following commands:
        (ALL : ALL) ALL

A practical test was also performed:

    sudo whoami

Result:

    root

## File Permissions

Created a test file owned by `andrea`:

    /home/andrea/test-permissions.txt

Permissions were changed to:

    chmod 640 /home/andrea/test-permissions.txt

Final permissions:

    -rw-r----- 1 andrea andrea

This means:

- Owner (`andrea`): read and write
- Group (`andrea`): read only
- Others: no permissions

## Permission Test

The file was populated by `andrea`.

The `luca` user then attempted to read the file without using `sudo`:

    cat /home/andrea/test-permissions.txt

Result:

    Permission denied

This confirms that Linux file permissions correctly prevent unauthorized access.

## Commands Practiced

- `id`
- `getent group`
- `useradd`
- `passwd`
- `usermod`
- `groupadd`
- `chmod`
- `ls -l`
- `su`
- `sudo`
- `visudo`
- `cat`
