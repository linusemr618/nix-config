{ config, lib, pkgs, ... }:

{
  # Swapfile configuration for btrfs with hibernation support
  # 
  # Important notes for btrfs swapfiles:
  # 1. The swapfile must have CoW (Copy-on-Write) disabled before creation
  # 2. The swapfile must not be compressed
  # 3. For hibernation, you need to calculate the swap offset using:
  #    btrfs inspect-internal map-swapfile -r /var/swapfile
  #    Then update boot.kernelParams with: resume_offset=<calculated_offset>
  
  # Swapfile will be created by NixOS at /var/swapfile
  # Size is 16GB - suitable for systems with 8-16GB RAM
  swapDevices = [{
    device = "/var/swapfile";
    size = 16 * 1024; # 16GB in MB
  }];

  # Resume device for hibernation (the encrypted root partition)
  # This must match the root device in hardware-configuration.nix
  # For this specific host (e15411), it's the LUKS-encrypted btrfs partition
  boot.resumeDevice = "/dev/mapper/luks-790845fb-5510-436c-9e2b-3abff24f506a";
  
  # Kernel parameter for hibernation resume
  # NOTE: The resume_offset needs to be calculated after the swapfile is created
  # Run this command after first boot to get the correct offset:
  #   sudo btrfs inspect-internal map-swapfile -r /var/swapfile
  # Then update this configuration with the actual offset value
  boot.kernelParams = [
    "resume_offset=0"  # FIXME: Update with actual offset from: btrfs inspect-internal map-swapfile -r /var/swapfile
  ];

  # Systemd service to handle btrfs-specific swapfile setup
  systemd.services.btrfs-swapfile-setup = {
    description = "Prepare swapfile for btrfs filesystem";
    requiredBy = [ "var-swapfile.swap" ];
    before = [ "var-swapfile.swap" ];
    
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    
    # This service runs before the swapfile is activated
    # It ensures CoW is disabled on the swapfile directory/file
    script = ''
      SWAPFILE="/var/swapfile"
      
      # Create parent directory if it doesn't exist
      mkdir -p $(dirname "$SWAPFILE")
      
      # If swapfile already exists, ensure CoW is disabled
      if [ -f "$SWAPFILE" ]; then
        echo "Swapfile exists, ensuring CoW is disabled..."
        ${pkgs.btrfs-progs}/bin/chattr +C "$SWAPFILE" 2>/dev/null || true
      else
        echo "Swapfile will be created by NixOS swap activation"
        # Disable CoW on the directory so new files inherit this attribute
        ${pkgs.btrfs-progs}/bin/chattr +C $(dirname "$SWAPFILE") 2>/dev/null || true
      fi
      
      # After swapfile is created and activated, print instructions for hibernation
      if [ -f "$SWAPFILE" ]; then
        if ${pkgs.util-linux}/bin/swapon --show | grep -q "$SWAPFILE"; then
          echo "=========================================="
          echo "Swapfile is active. To enable hibernation:"
          echo "1. Run this command to get the swap offset:"
          echo "   sudo btrfs inspect-internal map-swapfile -r $SWAPFILE"
          echo "2. Update hosts/common/global/swap.nix in your configuration"
          echo "   Change 'resume_offset=0' to 'resume_offset=<value_from_step_1>'"
          echo "3. Rebuild your system: sudo nixos-rebuild switch"
          echo "=========================================="
        fi
      fi
    '';
  };

  # Power management configuration for hibernation
  systemd.sleep.extraConfig = ''
    # Allow hybrid sleep with hibernation after 30 minutes
    HibernateDelaySec=30m
  '';
  
  # Enable hibernation and suspend
  systemd.targets.hibernate.enable = true;
  systemd.targets.sleep.enable = true;
}
