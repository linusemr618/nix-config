{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostsLaptop

      self.nixosModules.core
      self.nixosModules.desktop
      self.nixosModules.desktopNiri

      ({config, ...}: {
        home-manager.users.${config.user.name}.imports = [
          self.homeModules.core
          self.homeModules.desktop
          self.homeModules.desktopNiri
        ];
      })
    ];
  };
  flake.nixosModules.hostsLaptop = {pkgs, ...}: {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;
    networking.hostName = "laptop";

    hardware.enableRedistributableFirmware = true;
    services.fwupd.enable = true;

    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vpl-gpu-rt
        intel-compute-runtime
      ];
    };
    services.xserver.videoDrivers = ["modesetting"];
    environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};
    boot.kernelParams = ["i915.enable_guc=3"];
  };
}
