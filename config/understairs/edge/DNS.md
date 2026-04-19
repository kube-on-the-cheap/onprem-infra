# DNS Resolution Control

All LAN clients receive `192.168.20.200` (Pi-hole) as their DNS server via DHCP.
Resolution is enforced at multiple layers to prevent bypass.

## Resolution chain

```
LAN clients --> Pi-hole (port 53) --> Unbound (port 5335) --> Root servers
```

## Enforcement layers

### 1. Forced DNS (MikroTik firewall)

All outbound DNS traffic (UDP/TCP port 53) is dropped at the edge, except from the
Pi-hole recursor itself. This prevents clients from using alternative resolvers.

- Source: `modules/edge/firewall.forward.tf`

### 2. Encrypted DNS blocking (MikroTik firewall)

Alternative DNS protocols are blocked outbound via firewall rules:

- **DoH (DNS-over-HTTPS)**: SNI-based blocking of known DoH provider hostnames on port 443
- **DoT (DNS-over-TLS)**: TCP port 853 dropped
- **DoQ (DNS-over-QUIC)**: UDP port 853 dropped

- Source: `modules/edge/firewall.forward.tf`

### 3. DoH provider blacklist (Pi-hole)

Known DoH provider domains are blacklisted in Pi-hole, preventing clients from
resolving DoH endpoints in the first place. This complements the SNI-based
blocking at the edge firewall by catching requests before they reach the network.

- Source: `dibdot/DoH-IP-blocklists` (`doh-domains.txt`, Pi-hole adlist)

### 4. ECH/ESNI prevention (Pi-hole)

To keep SNI-based filtering effective, mechanisms that encrypt the TLS ClientHello
are neutralized at the DNS level:

- **ESNI**: `_esni.` subdomain queries blocked by Pi-hole (`dns.blockESNI = true`)
- **ECH**: HTTPS (type 65) and SVCB (type 64) DNS records stripped from responses
  via `filter-rr=HTTPS` and `filter-rr=SVCB` in Pi-hole's dnsmasq layer

Without HTTPS/SVCB records, clients cannot obtain ECH keys and fall back to
plaintext SNI.

- Config: `/etc/pihole/pihole.toml` (`misc.dnsmasq_lines`)

## Performance tuning (Pi-hole host)

- **Unbound**: `incoming-num-tcp: 1024` to handle higher concurrent TCP connection loads
- **Kernel**: `net.core.rmem_max` and `net.core.wmem_max` set to `5242880` (5 MB) to
  increase socket buffer sizes for DNS traffic bursts
