# Firewall Rules for PXE Boot and General Security
#
# Rule order matters! Rules are evaluated top-down.
# More specific rules should come before general drop rules.

# Allow TFTP from LAN for PXE boot
# TFTP uses UDP port 69 for initial connection
# resource "routeros_ip_firewall_filter" "allow_tftp_from_lan" {
#   chain    = "input"
#   action   = "accept"
#   protocol = "udp"
#   dst_port = "69"
#   in_interface_list = "LAN"
#   comment  = "Allow TFTP for PXE boot from LAN"

#   # Place this rule before the "drop all not coming from LAN" rule
#   # We need to explicitly set the place to insert it at the right position
#   place_before = 5  # Before rule #5 (drop all not coming from LAN)
# }
