#!/bin/bash
# Import script for existing RouterOS configuration

# Note: You may need to find the actual IDs from your RouterOS device
# Use: /interface/bridge/port print detail
#      /interface/list print detail
#      etc.

# Bridge ports - need to find IDs from RouterOS
echo "# Bridge ports (find IDs with: /interface/bridge/port print)"
echo 'terragrunt import "routeros_interface_bridge_port.ether2" "*2"'
echo 'terragrunt import "routeros_interface_bridge_port.ether3" "*3"'
echo 'terragrunt import "routeros_interface_bridge_port.ether4" "*4"'
echo 'terragrunt import "routeros_interface_bridge_port.ether5" "*5"'
echo 'terragrunt import "routeros_interface_bridge_port.ether6" "*6"'
echo 'terragrunt import "routeros_interface_bridge_port.ether7" "*7"'
echo 'terragrunt import "routeros_interface_bridge_port.ether8" "*8"'
echo 'terragrunt import "routeros_interface_bridge_port.sfp" "*9"'
echo ""

# Interface lists
echo "# Interface lists (find IDs with: /interface/list print)"
echo 'terragrunt import "routeros_interface_list.lan" "*0"'
echo 'terragrunt import "routeros_interface_list.wan" "*1"'
echo ""

# Interface list members
echo "# Interface list members (find IDs with: /interface/list/member print)"
echo 'terragrunt import "routeros_interface_list_member.lan_bridge" "*0"'
echo 'terragrunt import "routeros_interface_list_member.wan_ether1" "*1"'
echo 'terragrunt import "routeros_interface_list_member.wan_pppoe" "*2"'
echo ""

# PPPoE client
echo "# PPPoE client (find ID with: /interface/pppoe-client print)"
echo 'terragrunt import "routeros_interface_pppoe_client.wan" "*0"'
echo ""

# DHCP Server
echo "# DHCP server (find ID with: /ip/dhcp-server print)"
echo 'terragrunt import "routeros_ip_dhcp_server.defconf" "*1"'
echo ""

# DHCP Server leases
echo "# DHCP leases (find IDs with: /ip/dhcp-server/lease print)"
echo 'terragrunt import "routeros_ip_dhcp_server_lease.dietpi" "*0"'
echo 'terragrunt import "routeros_ip_dhcp_server_lease.nas" "*1"'
echo 'terragrunt import "routeros_ip_dhcp_server_lease.nasser" "*2"'
echo 'terragrunt import "routeros_ip_dhcp_server_lease.simpleton" "*3"'
echo 'terragrunt import "routeros_ip_dhcp_server_lease.rainbowparty" "*4"'
echo ""

# DHCP Server network
echo "# DHCP network (find ID with: /ip/dhcp-server/network print)"
echo 'terragrunt import "routeros_ip_dhcp_server_network.lan" "*0"'
echo ""

# DHCP options
echo "# DHCP options (find IDs with: /ip/dhcp-server/option print)"
echo 'terragrunt import "routeros_ip_dhcp_server_option.boot_file_pxe_bios" "*0"'
echo 'terragrunt import "routeros_ip_dhcp_server_option.boot_file_pxe_uefi" "*1"'
echo 'terragrunt import "routeros_ip_dhcp_server_option.next_server" "*2"'
echo ""

# DNS settings
echo "# DNS (singleton resource)"
echo 'terragrunt import "routeros_ip_dns.dns" "."'
echo ""

# DNS records
echo "# DNS records (find IDs with: /ip/dns/static print)"
echo 'terragrunt import "routeros_ip_dns_record.router" "*0"'
echo ""

# Firewall filter rules
echo "# Firewall filter rules (find IDs with: /ip/firewall/filter print)"
echo '# Note: Order matters! Check the actual IDs on your router'
echo 'terragrunt import "routeros_ip_firewall_filter.input_accept_established" "*0"'
echo 'terragrunt import "routeros_ip_firewall_filter.input_drop_invalid" "*1"'
echo 'terragrunt import "routeros_ip_firewall_filter.input_accept_icmp" "*2"'
echo 'terragrunt import "routeros_ip_firewall_filter.input_accept_loopback" "*3"'
echo 'terragrunt import "routeros_ip_firewall_filter.input_drop_not_lan" "*4"'
echo 'terragrunt import "routeros_ip_firewall_filter.forward_accept_ipsec_in" "*5"'
echo 'terragrunt import "routeros_ip_firewall_filter.forward_accept_ipsec_out" "*6"'
echo 'terragrunt import "routeros_ip_firewall_filter.forward_fasttrack" "*7"'
echo 'terragrunt import "routeros_ip_firewall_filter.forward_accept_established" "*8"'
echo 'terragrunt import "routeros_ip_firewall_filter.forward_drop_invalid" "*9"'
echo 'terragrunt import "routeros_ip_firewall_filter.forward_drop_wan_not_dstnat" "*A"'
echo ""

# Firewall NAT
echo "# Firewall NAT (find ID with: /ip/firewall/nat print)"
echo 'terragrunt import "routeros_ip_firewall_nat.masquerade" "*0"'
echo ""

# Neighbor discovery
echo "# Neighbor discovery (singleton resource)"
echo 'terragrunt import "routeros_ip_neighbor_discovery_settings.discovery" "."'
echo ""

# SSH server
echo "# SSH server (singleton resource)"
echo 'terragrunt import "routeros_ip_ssh_server.ssh" "."'
echo ""

# System clock
echo "# System clock (singleton resource)"
echo 'terragrunt import "routeros_system_clock.clock" "."'
echo ""

# System note
echo "# System note (singleton resource)"
echo 'terragrunt import "routeros_system_note.note" "."'
echo ""

# MAC server
echo "# MAC server (singleton resource)"
echo 'terragrunt import "routeros_tool_mac_server.mac_server" "."'
echo ""

# MAC server winbox
echo "# MAC server winbox (singleton resource)"
echo 'terragrunt import "routeros_tool_mac_server_winbox.mac_winbox" "."'
echo ""
