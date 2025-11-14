#!/bin/bash
# Script to automatically generate import commands with actual RouterOS IDs
# Usage: ./generate_imports.sh > import_commands.txt

ROUTER="edge"

echo "# Generated import commands for RouterOS"
echo "# Run from: /Users/marco/Repositories/onprem-infra/config/understairs/edge"
echo ""

# Helper function to get ID for a resource
get_id() {
    local path=$1
    local filter=$2
    ssh $ROUTER -- ":put [${path} print as-value where ${filter}]" | grep -o '\.id=\*[0-9A-F]*' | head -1 | cut -d'=' -f2
}

# Bridge ports
echo "# Bridge Ports"
id=$(get_id "/interface/bridge/port" "interface=ether2")
[ -n "$id" ] && echo "terragrunt import 'routeros_interface_bridge_port.ether2' '$id'"

id=$(get_id "/interface/bridge/port" "interface=ether3")
[ -n "$id" ] && echo "terragrunt import 'routeros_interface_bridge_port.ether3' '$id'"

id=$(get_id "/interface/bridge/port" "interface=ether4")
[ -n "$id" ] && echo "terragrunt import 'routeros_interface_bridge_port.ether4' '$id'"

id=$(get_id "/interface/bridge/port" "interface=ether5")
[ -n "$id" ] && echo "terragrunt import 'routeros_interface_bridge_port.ether5' '$id'"

id=$(get_id "/interface/bridge/port" "interface=ether6")
[ -n "$id" ] && echo "terragrunt import 'routeros_interface_bridge_port.ether6' '$id'"

id=$(get_id "/interface/bridge/port" "interface=ether7")
[ -n "$id" ] && echo "terragrunt import 'routeros_interface_bridge_port.ether7' '$id'"

id=$(get_id "/interface/bridge/port" "interface=ether8")
[ -n "$id" ] && echo "terragrunt import 'routeros_interface_bridge_port.ether8' '$id'"

id=$(get_id "/interface/bridge/port" "interface=sfp-sfpplus1")
[ -n "$id" ] && echo "terragrunt import 'routeros_interface_bridge_port.sfp' '$id'"

echo ""
echo "# Interface Lists"
id=$(get_id "/interface/list" "name=LAN")
[ -n "$id" ] && echo "terragrunt import 'routeros_interface_list.lan' '$id'"

id=$(get_id "/interface/list" "name=WAN")
[ -n "$id" ] && echo "terragrunt import 'routeros_interface_list.wan' '$id'"

echo ""
echo "# Interface List Members"
id=$(ssh $ROUTER -- ':put [/interface/list/member print as-value where interface=bridge and list=LAN]' | grep -o '\.id=\*[0-9A-F]*' | head -1 | cut -d'=' -f2)
[ -n "$id" ] && echo "terragrunt import 'routeros_interface_list_member.lan_bridge' '$id'"

id=$(ssh $ROUTER -- ':put [/interface/list/member print as-value where interface=ether1 and list=WAN]' | grep -o '\.id=\*[0-9A-F]*' | head -1 | cut -d'=' -f2)
[ -n "$id" ] && echo "terragrunt import 'routeros_interface_list_member.wan_ether1' '$id'"

id=$(ssh $ROUTER -- ':put [/interface/list/member print as-value where interface=pppoe-out1 and list=WAN]' | grep -o '\.id=\*[0-9A-F]*' | head -1 | cut -d'=' -f2)
[ -n "$id" ] && echo "terragrunt import 'routeros_interface_list_member.wan_pppoe' '$id'"

echo ""
echo "# PPPoE Client"
id=$(get_id "/interface/pppoe-client" "name=pppoe-out1")
[ -n "$id" ] && echo "terragrunt import 'routeros_interface_pppoe_client.wan' '$id'"

echo ""
echo "# DHCP Server"
id=$(get_id "/ip/dhcp-server" "name=defconf")
[ -n "$id" ] && echo "terragrunt import 'routeros_ip_dhcp_server.dhcp_server' '$id'"

echo ""
echo "# DHCP Server Leases"
id=$(get_id "/ip/dhcp-server/lease" "address=192.168.20.200")
[ -n "$id" ] && echo "terragrunt import 'routeros_ip_dhcp_server_lease.dietpi' '$id'"

id=$(get_id "/ip/dhcp-server/lease" "address=192.168.20.15")
[ -n "$id" ] && echo "terragrunt import 'routeros_ip_dhcp_server_lease.nas' '$id'"

id=$(get_id "/ip/dhcp-server/lease" "address=192.168.20.16")
[ -n "$id" ] && echo "terragrunt import 'routeros_ip_dhcp_server_lease.nasser' '$id'"

id=$(get_id "/ip/dhcp-server/lease" "address=192.168.20.111")
[ -n "$id" ] && echo "terragrunt import 'routeros_ip_dhcp_server_lease.simpleton' '$id'"

id=$(get_id "/ip/dhcp-server/lease" "address=192.168.20.125")
[ -n "$id" ] && echo "terragrunt import 'routeros_ip_dhcp_server_lease.rainbowparty' '$id'"

echo ""
echo "# DHCP Server Network"
id=$(ssh $ROUTER -- ':put [/ip/dhcp-server/network print as-value where address~"192.168.20.0/24"]' | grep -o '\.id=\*[0-9A-F]*' | head -1 | cut -d'=' -f2)
[ -n "$id" ] && echo "terragrunt import 'routeros_ip_dhcp_server_network.lan' '$id'"

echo ""
echo "# DHCP Server Options"
id=$(get_id "/ip/dhcp-server/option" 'name="boot-file-pxe-bios"')
[ -n "$id" ] && echo "terragrunt import 'routeros_ip_dhcp_server_option.boot_file_pxe_bios' '$id'"

id=$(get_id "/ip/dhcp-server/option" 'name="boot-file-pxe-uefi"')
[ -n "$id" ] && echo "terragrunt import 'routeros_ip_dhcp_server_option.boot_file_pxe_uefi' '$id'"

id=$(get_id "/ip/dhcp-server/option" 'name="next-server"')
[ -n "$id" ] && echo "terragrunt import 'routeros_ip_dhcp_server_option.next_server' '$id'"

echo ""
echo "# DNS (singleton)"
echo "terragrunt import 'routeros_ip_dns.dns' '.'"

echo ""
echo "# DNS Records"
id=$(get_id "/ip/dns/static" "name=router.lan")
[ -n "$id" ] && echo "terragrunt import 'routeros_ip_dns_record.router' '$id'"

echo ""
echo "# Firewall Filter Rules"
echo "# Note: Order matters - verify these match your configuration!"

# Input chain rules
id=$(ssh $ROUTER -- ':put [/ip/firewall/filter print as-value where chain=input and connection-state~"established,related,untracked" and action=accept]' | grep -o '\.id=\*[0-9A-F]*' | head -1 | cut -d'=' -f2)
[ -n "$id" ] && echo "terragrunt import 'routeros_ip_firewall_filter.input_accept_established' '$id'"

id=$(ssh $ROUTER -- ':put [/ip/firewall/filter print as-value where chain=input and connection-state=invalid and action=drop]' | grep -o '\.id=\*[0-9A-F]*' | head -1 | cut -d'=' -f2)
[ -n "$id" ] && echo "terragrunt import 'routeros_ip_firewall_filter.input_drop_invalid' '$id'"

id=$(ssh $ROUTER -- ':put [/ip/firewall/filter print chain=input and protocol=icmp and action=accept]' | grep -o '^\*[0-9A-F]*' | head -1)
[ -n "$id" ] && echo "terragrunt import 'routeros_ip_firewall_filter.input_accept_icmp' '$id'"

id=$(ssh $ROUTER -- ':put [/ip/firewall/filter print as-value where chain=input and dst-address=127.0.0.1]' | grep -o '\.id=\*[0-9A-F]*' | head -1 | cut -d'=' -f2)
[ -n "$id" ] && echo "terragrunt import 'routeros_ip_firewall_filter.input_accept_loopback' '$id'"

id=$(ssh $ROUTER -- ':put [/ip/firewall/filter print as-value where chain=input and in-interface-list="!LAN"]' | grep -o '\.id=\*[0-9A-F]*' | head -1 | cut -d'=' -f2)
[ -n "$id" ] && echo "terragrunt import 'routeros_ip_firewall_filter.input_drop_not_lan' '$id'"

# Forward chain rules
id=$(ssh $ROUTER -- ':put [/ip/firewall/filter print as-value where chain=forward and ipsec-policy~"in,ipsec"]' | grep -o '\.id=\*[0-9A-F]*' | head -1 | cut -d'=' -f2)
[ -n "$id" ] && echo "terragrunt import 'routeros_ip_firewall_filter.forward_accept_ipsec_in' '$id'"

id=$(ssh $ROUTER -- ':put [/ip/firewall/filter print as-value where chain=forward and ipsec-policy~"out,ipsec"]' | grep -o '\.id=\*[0-9A-F]*' | head -1 | cut -d'=' -f2)
[ -n "$id" ] && echo "terragrunt import 'routeros_ip_firewall_filter.forward_accept_ipsec_out' '$id'"

id=$(ssh $ROUTER -- ':put [/ip/firewall/filter print as-value where chain=forward and action=fasttrack-connection]' | grep -o '\.id=\*[0-9A-F]*' | head -1 | cut -d'=' -f2)
[ -n "$id" ] && echo "terragrunt import 'routeros_ip_firewall_filter.forward_fasttrack' '$id'"

id=$(ssh $ROUTER -- ':put [/ip/firewall/filter print as-value where chain=forward and connection-state~"established,related,untracked" and action=accept]' | grep -o '\.id=\*[0-9A-F]*' | head -1 | cut -d'=' -f2)
[ -n "$id" ] && echo "terragrunt import 'routeros_ip_firewall_filter.forward_accept_established' '$id'"

id=$(ssh $ROUTER -- ':put [/ip/firewall/filter print as-value where chain=forward and connection-state=invalid and action=drop]' | grep -o '\.id=\*[0-9A-F]*' | head -1 | cut -d'=' -f2)
[ -n "$id" ] && echo "terragrunt import 'routeros_ip_firewall_filter.forward_drop_invalid' '$id'"

id=$(ssh $ROUTER -- ':put [/ip/firewall/filter print as-value where chain=forward and connection-nat-state="!dstnat"]' | grep -o '\.id=\*[0-9A-F]*' | head -1 | cut -d'=' -f2)
[ -n "$id" ] && echo "terragrunt import 'routeros_ip_firewall_filter.forward_drop_wan_not_dstnat' '$id'"

echo ""
echo "# Firewall NAT"
id=$(ssh $ROUTER -- ':put [/ip/firewall/nat print as-value where action=masquerade]' | grep -o '\.id=\*[0-9A-F]*' | head -1 | cut -d'=' -f2)
[ -n "$id" ] && echo "terragrunt import 'routeros_ip_firewall_nat.masquerade' '$id'"

echo ""
echo "# Singleton resources"
echo "terragrunt import 'routeros_ip_neighbor_discovery_settings.discovery' '.'"
echo "terragrunt import 'routeros_ip_ssh_server.ssh' '.'"
echo "terragrunt import 'routeros_system_clock.clock' '.'"
echo "terragrunt import 'routeros_system_note.note' '.'"
echo "terragrunt import 'routeros_tool_mac_server.mac_server' '.'"
echo "terragrunt import 'routeros_tool_mac_server_winbox.mac_winbox' '.'"

echo ""
echo "# Run these commands from: /Users/marco/Repositories/onprem-infra/config/understairs/edge"
