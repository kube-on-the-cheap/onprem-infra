# Container Package Configuration
#
# Enables container support on MikroTik RouterOS
# Required for running Docker containers

# Install container package
# Note: This requires RouterOS 7.4+ and may require a reboot
resource "routeros_system_script" "install_container_package" {
  name   = "install-container-package"
  policy = ["read", "write", "reboot"]
  source = <<-EOT
    # Check if container package is already installed
    :if ([/system package find name=container] != "") do={
      :log info "Container package already installed"
    } else={
      :log info "Installing container package..."
      :do {
        /system package update install container
        :log info "Container package installed - reboot required"
        :log warning "Run /system reboot to activate container support"
      } on-error={
        :log error "Failed to install container package"
        :log error "Ensure RouterOS version is 7.4 or newer"
      }
    }
  EOT
}

# Instructions for container usage
resource "routeros_system_script" "container_instructions" {
  name   = "container-usage-instructions"
  policy = ["read"]
  source = <<-EOT
    :log info "=== Container Package Usage ==="
    :log info ""
    :log info "1. Install container package:"
    :log info "   /system script run install-container-package"
    :log info "   /system reboot"
    :log info ""
    :log info "2. After reboot, verify installation:"
    :log info "   /system package print where name=container"
    :log info ""
    :log info "3. Configure container storage (use USB drive):"
    :log info "   /container config set ram-high=512.0MiB tmpdir=usb1-part2/container/tmp"
    :log info "   /file make-directory name=usb1-part2/container"
    :log info ""
    :log info "4. Add container registry:"
    :log info "   /container envs add name=pihole key=TZ value=\"Europe/London\""
    :log info "   /container add remote-image=pihole/pihole:latest interface=veth1 root-dir=usb1-part2/container/pihole envlist=pihole"
    :log info ""
    :log info "5. Start container:"
    :log info "   /container start 0"
    :log info ""
    :log info "Documentation: https://help.mikrotik.com/docs/display/ROS/Container"
    :log info ""
  EOT
}
