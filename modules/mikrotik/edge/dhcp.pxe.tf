# DHCP Server Options for PXE Boot
resource "routeros_ip_dhcp_server_option" "boot_file_pxe_uefi" {
  name  = "boot-file-pxe-uefi"
  code  = 67
  value = "s'snponly.efi'"
}

resource "routeros_ip_dhcp_server_option" "boot_file_pxe_bios" {
  name  = "boot-file-pxe-bios"
  code  = 67
  value = "s'undionly.kpxe'"
}

resource "routeros_ip_dhcp_server_option" "next_server" {
  name  = "next-server"
  code  = 66
  value = "s'192.168.20.200'"
}
