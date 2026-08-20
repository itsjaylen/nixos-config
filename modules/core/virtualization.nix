{ pkgs, username, ... }:
{
  # Add user to virtualization and container groups
  users.users.${username}.extraGroups = [
    "libvirtd"
    "docker"
  ];

  # Install necessary packages for VM management and guest interaction
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    virtio-win
    win-spice
    adwaita-icon-theme
  ];

  # Manage virtualization daemons and hypervisor options
  virtualisation = {
    docker = {
      enable = true;
    };

    libvirtd = {
      enable = true;
      qemu = {
        # Use host KVM package for better performance
        package = pkgs.qemu_kvm;

        # Enables Software TPM 2.0 emulation (Required for Windows 11 guest VMs)
        swtpm.enable = true;
      };
    };

    # Enable direct USB device passthrough in virt-manager
    spiceUSBRedirection.enable = true;
  };

  # Enables SPICE agent daemon for seamless clipboard sharing and auto-resizing
  services.spice-vdagentd.enable = true;
}