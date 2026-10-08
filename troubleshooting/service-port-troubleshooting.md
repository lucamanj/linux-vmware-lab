# Service / Port Troubleshooting

## Scenario

An application should be running on a specific port, but a user cannot reach it.

The goal is to verify which ports are listening, identify the process using the port, and test the service connection.

## 1. Check listening ports

Command:

```bash
ss -tulpn
```

Important options:

- `-t` → TCP
- `-u` → UDP
- `-l` → listening
- `-p` → process/program
- `-n` → numeric addresses and ports

Relevant output:

```text
tcp   LISTEN 0      4096         0.0.0.0:22        0.0.0.0:*
tcp   LISTEN 0      4096            [::]:22           [::]:*
```

Port `22` is listening on both IPv4 and IPv6.

## 2. Identify the process using port 22

Command:

```bash
sudo ss -tulpn | grep ':22'
```

Output:

```text
tcp   LISTEN 0      4096         0.0.0.0:22        0.0.0.0:*    users:(("systemd",pid=1,fd=66))
tcp   LISTEN 0      4096            [::]:22           [::]:*    users:(("systemd",pid=1,fd=67))
```

The port is managed by `systemd` through socket activation.

## 3. Check the SSH socket

Command:

```bash
systemctl status ssh.socket --no-pager
```

Result:

```text
Active: active (listening)
Listen: 0.0.0.0:22 (Stream)
        [::]:22 (Stream)
Triggers: ● ssh.service
```

The SSH socket is active and listening on port 22.

## 4. Check the SSH service

Before establishing a connection:

```text
Active: inactive (dead)
TriggeredBy: ● ssh.socket
```

This is expected because SSH is configured to use **systemd socket activation**.

## 5. Test the connection

Command:

```bash
ssh localhost
```

The connection was successful and an interactive SSH session was established.

## 6. Verify service activation

After connecting through SSH:

```bash
systemctl status ssh.service --no-pager
```

Result:

```text
Active: active (running)
TriggeredBy: ● ssh.socket
Main PID: 1768 (sshd)
```

The SSH service was started automatically when the connection was received by `ssh.socket`.

## Conclusion

The troubleshooting confirmed that:

- Port `22` is listening.
- The SSH socket is active.
- SSH connections are accepted successfully.
- `ssh.service` is activated on demand by `ssh.socket`.
- The SSH server is therefore correctly configured and operational.

This demonstrates how to troubleshoot a service that appears inactive while its socket is still listening and able to activate the service when a connection arrives.
