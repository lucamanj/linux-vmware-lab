# Network Troubleshooting Lab

## Scenario

The server is reported to have network connectivity issues.

The objective is to verify:

- Network interfaces and IP configuration
- Routing table
- Gateway connectivity
- Route selection
- Internet connectivity
- DNS resolution

## 1. Check network interfaces

Command:

`ip a`

The `eth0` interface is UP and has the IPv4 address `172.30.24.55/20`.

The loopback interface `lo` is also correctly configured with `127.0.0.1`.

## 2. Check routing table

Command:

`ip r`

The system has:

- Network: `172.30.16.0/20`
- Default gateway: `172.30.16.1`
- Interface: `eth0`

## 3. Test gateway connectivity

Command:

`ping -c 4 172.30.16.1`

Result:

`100% packet loss`

The gateway does not respond to ICMP requests.

This does not necessarily indicate a network failure because ICMP traffic may be filtered.

## 4. Verify route selection

Command:

`ip route get 172.30.16.1`

Result:

The kernel uses `eth0` with source address `172.30.24.55`.

The local routing configuration is therefore correct.

## 5. Test Internet connectivity

Command:

`ping -c 4 8.8.8.8`

Result:

`4 packets transmitted, 4 received, 0% packet loss`

Internet connectivity is working correctly.

## 6. Test DNS resolution

Command:

`ping -c 4 google.com`

Result:

The hostname is successfully resolved to an IP address and all packets are received.

DNS resolution is working correctly.

## Conclusion

The network configuration is correct and Internet connectivity is available.

Although the default gateway does not respond to ICMP requests, this is not sufficient to conclude that the gateway or network is down.

The route is correctly configured, Internet connectivity works, and DNS resolution works.

### Commands used

- `ip a`
- `ip r`
- `ping`
- `ip route get`
