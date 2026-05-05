# DNS Resolution Control

All LAN clients receive `192.168.20.1` (MikroTik edge router) as their DNS server
via DHCP. The router acts as a caching forwarder to upstream resolvers (Cloudflare,
Google). Resolution is enforced at multiple layers to prevent bypass.

## Resolution chain

```
LAN clients --> MikroTik (port 53, caching forwarder) --> Upstream resolvers (1.1.1.1, 8.8.8.8)
```

## Enforcement layers

### 1. Forced DNS (MikroTik firewall)

All outbound DNS traffic (UDP/TCP port 53) from LAN clients is dropped at the edge.
Since the router itself originates DNS queries (output chain, not forward chain),
no explicit exception is needed. This prevents clients from using alternative resolvers.

- Source: `modules/edge/firewall.forward.tf`

### 2. Encrypted DNS blocking (MikroTik firewall)

Alternative DNS protocols are blocked outbound via firewall rules:

- **DoH (DNS-over-HTTPS)**: SNI-based blocking of known DoH provider hostnames on port 443
- **DoT (DNS-over-TLS)**: TCP port 853 dropped
- **DoQ (DNS-over-QUIC)**: UDP port 853 dropped

- Source: `modules/edge/firewall.forward.tf`

### 3. DoH provider blacklist

Previously handled by Pi-hole adlists. With MikroTik as the resolver, DoH provider
domains are blocked only at the SNI level (layer 2 above). Consider adding MikroTik
static DNS entries for known DoH domains pointing to `0.0.0.0` if DNS-level blocking
is desired.
