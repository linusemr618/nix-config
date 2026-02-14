{ pkgs, ... }: {
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  hardware.enableRedistributableFirmware = true;

  # Enable firmware updates
  services.fwupd.enable = true;
  
  # Use systemd in initrd for faster boot
  boot.initrd.systemd.enable = true;
}
