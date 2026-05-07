{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.e15411-nixos = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.e15411
    ];
  };
  flake.nixosModules.e15411 = {
    config,
    pkgs,
    ...
  }: {
    imports = [
      self.nixosModules.core
      self.nixosModules.desktop
    ];

    home-manager.users.${config.user.name}.imports = [
      self.homeModules.core
      self.homeModules.desktop
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;
    networking.hostName = "e15411-nixos";

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
