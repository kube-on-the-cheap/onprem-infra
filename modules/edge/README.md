# edge

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_routeros"></a> [routeros](#requirement\_routeros) | 1.89.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_routeros"></a> [routeros](#provider\_routeros) | 1.89.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [routeros_disk_settings.disk](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/disk_settings) | resource |
| [routeros_interface_bridge.lan](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/interface_bridge) | resource |
| [routeros_interface_bridge_port.lan_interfaces](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/interface_bridge_port) | resource |
| [routeros_interface_ethernet.ether1](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/interface_ethernet) | resource |
| [routeros_interface_ethernet.ether2](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/interface_ethernet) | resource |
| [routeros_interface_ethernet.ether3](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/interface_ethernet) | resource |
| [routeros_interface_ethernet.ether4](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/interface_ethernet) | resource |
| [routeros_interface_ethernet.ether5](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/interface_ethernet) | resource |
| [routeros_interface_ethernet.ether6](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/interface_ethernet) | resource |
| [routeros_interface_ethernet.ether7](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/interface_ethernet) | resource |
| [routeros_interface_ethernet.ether8](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/interface_ethernet) | resource |
| [routeros_interface_ethernet.sfp-sfpplus1](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/interface_ethernet) | resource |
| [routeros_interface_list.lan](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/interface_list) | resource |
| [routeros_interface_list.wan](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/interface_list) | resource |
| [routeros_interface_list_member.lan_bridge](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/interface_list_member) | resource |
| [routeros_interface_list_member.wan_ether1](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/interface_list_member) | resource |
| [routeros_interface_list_member.wan_pppoe](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/interface_list_member) | resource |
| [routeros_interface_pppoe_client.wan](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/interface_pppoe_client) | resource |
| [routeros_ip_address.lan](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_address) | resource |
| [routeros_ip_dhcp_server.dhcp_server](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_dhcp_server) | resource |
| [routeros_ip_dhcp_server_lease.dietpi](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_dhcp_server_lease) | resource |
| [routeros_ip_dhcp_server_lease.minipc](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_dhcp_server_lease) | resource |
| [routeros_ip_dhcp_server_lease.nas](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_dhcp_server_lease) | resource |
| [routeros_ip_dhcp_server_lease.nasser](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_dhcp_server_lease) | resource |
| [routeros_ip_dhcp_server_lease.pi4](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_dhcp_server_lease) | resource |
| [routeros_ip_dhcp_server_lease.rainbowparty](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_dhcp_server_lease) | resource |
| [routeros_ip_dhcp_server_lease.simpleton](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_dhcp_server_lease) | resource |
| [routeros_ip_dhcp_server_network.lan](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_dhcp_server_network) | resource |
| [routeros_ip_dhcp_server_option.boot_file_pxe_bios](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_dhcp_server_option) | resource |
| [routeros_ip_dhcp_server_option.boot_file_pxe_uefi](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_dhcp_server_option) | resource |
| [routeros_ip_dhcp_server_option.next_server](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_dhcp_server_option) | resource |
| [routeros_ip_dns.dns](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_dns) | resource |
| [routeros_ip_firewall_filter.forward_accept_established](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_firewall_filter) | resource |
| [routeros_ip_firewall_filter.forward_accept_ipsec_in](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_firewall_filter) | resource |
| [routeros_ip_firewall_filter.forward_accept_ipsec_out](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_firewall_filter) | resource |
| [routeros_ip_firewall_filter.forward_drop_dns_tcp](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_firewall_filter) | resource |
| [routeros_ip_firewall_filter.forward_drop_dns_udp](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_firewall_filter) | resource |
| [routeros_ip_firewall_filter.forward_drop_doh](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_firewall_filter) | resource |
| [routeros_ip_firewall_filter.forward_drop_doq](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_firewall_filter) | resource |
| [routeros_ip_firewall_filter.forward_drop_dot](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_firewall_filter) | resource |
| [routeros_ip_firewall_filter.forward_drop_invalid](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_firewall_filter) | resource |
| [routeros_ip_firewall_filter.forward_drop_wan_not_dstnat](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_firewall_filter) | resource |
| [routeros_ip_firewall_filter.forward_fasttrack](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_firewall_filter) | resource |
| [routeros_ip_firewall_filter.input_accept_dns_tcp](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_firewall_filter) | resource |
| [routeros_ip_firewall_filter.input_accept_dns_udp](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_firewall_filter) | resource |
| [routeros_ip_firewall_filter.input_accept_established](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_firewall_filter) | resource |
| [routeros_ip_firewall_filter.input_accept_icmp](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_firewall_filter) | resource |
| [routeros_ip_firewall_filter.input_accept_loopback](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_firewall_filter) | resource |
| [routeros_ip_firewall_filter.input_accept_tftp_pxe](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_firewall_filter) | resource |
| [routeros_ip_firewall_filter.input_drop_invalid](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_firewall_filter) | resource |
| [routeros_ip_firewall_filter.input_drop_not_lan](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_firewall_filter) | resource |
| [routeros_ip_firewall_nat.masquerade](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_firewall_nat) | resource |
| [routeros_ip_neighbor_discovery_settings.discovery](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_neighbor_discovery_settings) | resource |
| [routeros_ip_pool.dhcp](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_pool) | resource |
| [routeros_ip_ssh_server.ssh](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ip_ssh_server) | resource |
| [routeros_ipv6_firewall_addr_list.bad_ipv6_6bone](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_addr_list) | resource |
| [routeros_ipv6_firewall_addr_list.bad_ipv6_discard](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_addr_list) | resource |
| [routeros_ipv6_firewall_addr_list.bad_ipv6_documentation](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_addr_list) | resource |
| [routeros_ipv6_firewall_addr_list.bad_ipv6_ipv4_compat](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_addr_list) | resource |
| [routeros_ipv6_firewall_addr_list.bad_ipv6_ipv4_mapped](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_addr_list) | resource |
| [routeros_ipv6_firewall_addr_list.bad_ipv6_loopback](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_addr_list) | resource |
| [routeros_ipv6_firewall_addr_list.bad_ipv6_orchid](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_addr_list) | resource |
| [routeros_ipv6_firewall_addr_list.bad_ipv6_site_local](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_addr_list) | resource |
| [routeros_ipv6_firewall_addr_list.bad_ipv6_unspecified](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_addr_list) | resource |
| [routeros_ipv6_firewall_filter.forward_accept_established](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_filter) | resource |
| [routeros_ipv6_firewall_filter.forward_accept_hip](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_filter) | resource |
| [routeros_ipv6_firewall_filter.forward_accept_icmpv6](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_filter) | resource |
| [routeros_ipv6_firewall_filter.forward_accept_ike](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_filter) | resource |
| [routeros_ipv6_firewall_filter.forward_accept_ipsec_ah](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_filter) | resource |
| [routeros_ipv6_firewall_filter.forward_accept_ipsec_esp](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_filter) | resource |
| [routeros_ipv6_firewall_filter.forward_accept_ipsec_policy](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_filter) | resource |
| [routeros_ipv6_firewall_filter.forward_drop_bad_dst](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_filter) | resource |
| [routeros_ipv6_firewall_filter.forward_drop_bad_src](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_filter) | resource |
| [routeros_ipv6_firewall_filter.forward_drop_hop_limit](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_filter) | resource |
| [routeros_ipv6_firewall_filter.forward_drop_invalid](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_filter) | resource |
| [routeros_ipv6_firewall_filter.forward_drop_not_lan](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_filter) | resource |
| [routeros_ipv6_firewall_filter.input_accept_dhcpv6](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_filter) | resource |
| [routeros_ipv6_firewall_filter.input_accept_established](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_filter) | resource |
| [routeros_ipv6_firewall_filter.input_accept_icmpv6](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_filter) | resource |
| [routeros_ipv6_firewall_filter.input_accept_ike](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_filter) | resource |
| [routeros_ipv6_firewall_filter.input_accept_ipsec_ah](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_filter) | resource |
| [routeros_ipv6_firewall_filter.input_accept_ipsec_esp](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_filter) | resource |
| [routeros_ipv6_firewall_filter.input_accept_ipsec_policy](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_filter) | resource |
| [routeros_ipv6_firewall_filter.input_accept_udp_traceroute](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_filter) | resource |
| [routeros_ipv6_firewall_filter.input_drop_invalid](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_filter) | resource |
| [routeros_ipv6_firewall_filter.input_drop_not_lan](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/ipv6_firewall_filter) | resource |
| [routeros_move_items.forward_chain_order](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/move_items) | resource |
| [routeros_system_clock.clock](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/system_clock) | resource |
| [routeros_system_note.note](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/system_note) | resource |
| [routeros_system_ntp_client.ntp](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/system_ntp_client) | resource |
| [routeros_system_user.admin](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/system_user) | resource |
| [routeros_system_user.tfadmin](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/system_user) | resource |
| [routeros_system_user_sshkeys.admin_key](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/system_user_sshkeys) | resource |
| [routeros_tool_mac_server.mac_server](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/tool_mac_server) | resource |
| [routeros_tool_mac_server_winbox.mac_winbox](https://registry.terraform.io/providers/terraform-routeros/routeros/1.89.0/docs/resources/tool_mac_server_winbox) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_ssh_public_key"></a> [admin\_ssh\_public\_key](#input\_admin\_ssh\_public\_key) | SSH public key for admin user authentication.<br/>Must be in OpenSSH public key format starting with 'ssh-rsa' or 'ssh-ed25519'.<br/>Example: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC6... user@host'<br/><br/>Note: RouterOS 7.7+ required for ed25519 keys. RSA keys are most compatible.<br/>Generate with: ssh-keygen -t rsa -b 4096 | `string` | n/a | yes |
| <a name="input_pppoe_credentials"></a> [pppoe\_credentials](#input\_pppoe\_credentials) | The PPPoE credentials (username and password) to use with the service | <pre>object({<br/>    username = string<br/>    password = string<br/>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
