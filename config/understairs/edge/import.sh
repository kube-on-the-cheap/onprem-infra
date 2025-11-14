#!/bin/bash
# Import script for existing RouterOS configuration into Terraform state
# Run this from: /Users/marco/Repositories/onprem-infra/config/understairs/edge

set -e

echo "Starting import of RouterOS resources..."
echo ""

# Bridge ports - need to find IDs from RouterOS
echo "==> Importing bridge ports..."
terragrunt import "routeros_interface_bridge_port.ether2" "*2" || true
terragrunt import "routeros_interface_bridge_port.ether3" "*3" || true
terragrunt import "routeros_interface_bridge_port.ether4" "*4" || true
terragrunt import "routeros_interface_bridge_port.ether5" "*5" || true
terragrunt import "routeros_interface_bridge_port.ether6" "*6" || true
terragrunt import "routeros_interface_bridge_port.ether7" "*7" || true
terragrunt import "routeros_interface_bridge_port.ether8" "*8" || true
terragrunt import "routeros_interface_bridge_port.sfp" "*9" || true

# Interface lists
echo ""
echo "==> Importing interface lists..."
terragrunt import "routeros_interface_list.lan" "*0" || true
terragrunt import "routeros_interface_list.wan" "*1" || true

# Interface list members
echo ""
echo "==> Importing interface list members..."
terragrunt import "routeros_interface_list_member.lan_bridge" "*0" || true
terragrunt import "routeros_interface_list_member.wan_ether1" "*1" || true
terragrunt import "routeros_interface_list_member.wan_pppoe" "*2" || true

# PPPoE client
echo ""
echo "==> Importing PPPoE client..."
terragrunt import "routeros_interface_pppoe_client.wan" "*0" || true

# DHCP Server
echo ""
echo "==> Importing DHCP server..."
terragrunt import "routeros_ip_dhcp_server.defconf" "*1" || true

# DHCP Server leases
echo ""
echo "==> Importing DHCP leases..."
terragrunt import "routeros_ip_dhcp_server_lease.dietpi" "*0" || true
terragrunt import "routeros_ip_dhcp_server_lease.nas" "*2" || true
terragrunt import "routeros_ip_dhcp_server_lease.nasser" "*1" || true
terragrunt import "routeros_ip_dhcp_server_lease.simpleton" "*3" || true
terragrunt import "routeros_ip_dhcp_server_lease.rainbowparty" "*4" || true

# DHCP Server network
echo ""
echo "==> Importing DHCP network..."
terragrunt import "routeros_ip_dhcp_server_network.lan" "*0" || true

# DHCP options
echo ""
echo "==> Importing DHCP options..."
terragrunt import "routeros_ip_dhcp_server_option.boot_file_pxe_bios" "*1" || true
terragrunt import "routeros_ip_dhcp_server_option.boot_file_pxe_uefi" "*0" || true
terragrunt import "routeros_ip_dhcp_server_option.next_server" "*2" || true

# DNS settings
echo ""
echo "==> Importing DNS settings..."
terragrunt import "routeros_ip_dns.dns" "." || true

# DNS records
echo ""
echo "==> Importing DNS records..."
terragrunt import "routeros_ip_dns_record.router" "*0" || true

# Firewall filter rules
echo ""
echo "==> Importing firewall filter rules..."
terragrunt import "routeros_ip_firewall_filter.input_accept_established" "*0" || true
terragrunt import "routeros_ip_firewall_filter.input_drop_invalid" "*1" || true
terragrunt import "routeros_ip_firewall_filter.input_accept_icmp" "*2" || true
terragrunt import "routeros_ip_firewall_filter.input_accept_loopback" "*3" || true
terragrunt import "routeros_ip_firewall_filter.input_drop_not_lan" "*4" || true
terragrunt import "routeros_ip_firewall_filter.forward_accept_ipsec_in" "*5" || true
terragrunt import "routeros_ip_firewall_filter.forward_accept_ipsec_out" "*6" || true
terragrunt import "routeros_ip_firewall_filter.forward_fasttrack" "*7" || true
terragrunt import "routeros_ip_firewall_filter.forward_accept_established" "*8" || true
terragrunt import "routeros_ip_firewall_filter.forward_drop_invalid" "*9" || true
terragrunt import "routeros_ip_firewall_filter.forward_drop_wan_not_dstnat" "*A" || true

# Firewall NAT
echo ""
echo "==> Importing firewall NAT..."
terragrunt import "routeros_ip_firewall_nat.masquerade" "*0" || true

# Neighbor discovery
echo ""
echo "==> Importing neighbor discovery settings..."
terragrunt import "routeros_ip_neighbor_discovery_settings.discovery" "." || true

# SSH server
echo ""
echo "==> Importing SSH server..."
terragrunt import "routeros_ip_ssh_server.ssh" "." || true

# System clock
echo ""
echo "==> Importing system clock..."
terragrunt import "routeros_system_clock.clock" "." || true

# System note
echo ""
echo "==> Importing system note..."
terragrunt import "routeros_system_note.note" "." || true

# MAC server
echo ""
echo "==> Importing MAC server..."
terragrunt import "routeros_tool_mac_server.mac_server" "." || true

# MAC server winbox
echo ""
echo "==> Importing MAC server winbox..."
terragrunt import "routeros_tool_mac_server_winbox.mac_winbox" "." || true

echo ""
echo "Import complete! Run 'terragrunt plan' to verify the state."
