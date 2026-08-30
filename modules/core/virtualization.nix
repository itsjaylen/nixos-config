{ pkgs, username, ... }:
{
  # Enable virt-manager service integration
  programs.virt-manager.enable = true;

  # Add user to virtualization and container groups
  users.users.${username}.extraGroups = [
    "libvirtd"
    "docker"
  ];

  # Install necessary packages for VM management, guest interaction, and networking
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    virtio-win
    win-spice
    adwaita-icon-theme
    dnsmasq # Required for libvirt default network DHCP/DNS
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

    # Override hardware specs for testing with `nixos-rebuild build-vm`
    vmVariant = {
      virtualisation = {
        memorySize = 8192; # 8GB RAM
        cores = 4; # 4 CPU cores
      };
    };
  };

  # Enables SPICE agent daemon for seamless clipboard sharing and auto-resizing
  services.spice-vdagentd.enable = true;

  # Optional: Trust the libvirt bridge interface to prevent firewall blocking
  networking.firewall.trustedInterfaces = [ "virbr0" ];
}