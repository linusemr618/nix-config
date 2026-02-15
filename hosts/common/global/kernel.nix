{pkgs, ...}: {
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.enableRedistributableFirmware = true;

  services.fwupd.enable = true;
}
