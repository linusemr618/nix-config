# Virtualization and containerization
{pkgs, ...}: {
  # Enable QEMU/KVM virtualization
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      ovmf.enable = true; # UEFI support
      swtpm.enable = true; # TPM emulation
    };
  };
  
  # Enable Podman (Docker alternative)
  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # Create docker alias for podman
    defaultNetwork.settings.dns_enabled = true;
  };
  
  # Virtualization packages
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    quickemu # Easy VM creation
  ];
  
  # Add user to libvirtd group (adjust username as needed)
  # users.users.linus.extraGroups = [ "libvirtd" ];
}
