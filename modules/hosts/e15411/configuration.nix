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
  flake.nixosModules.e15411 = {pkgs, ...}: {
    imports = [
      self.nixosModules.linus
      self.nixosModules.core
      self.nixosModules.desktop
    ];

    home-manager.users.linus.imports = [
      self.homeModules.linus
      self.homeModules.core
      self.homeModules.desktop
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;
    networking.hostName = "e15411-nixos"; # Define your hostname.
    # networking.wireless.enable = true;
    networking.networkmanager.enable = true;
    time.timeZone = "Europe/Berlin";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
    console.keyMap = "de";
    services.printing.enable = true;
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      #jack.enable = true;
      #media-session.enable = true;
    };
    # services.xserver.libinput.enable = true;
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = ["nix-command" "flakes"];
    environment.systemPackages = with pkgs; [
      vim
      wget
      git
    ];
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
    # services.openssh.enable = true;
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # networking.firewall.enable = false;

    system.stateVersion = "26.05"; # Did you read the comment?

    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;

    hardware.enableRedistributableFirmware = true;
    services.fwupd.enable = true;
    boot.kernelModules = ["sg"];

    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver # For Broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
        vpl-gpu-rt
        intel-compute-runtime
      ];
    };
    services.xserver.videoDrivers = ["modesetting"];
    environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";}; # Optionally, set the environment variable
    boot.kernelParams = ["i915.enable_guc=3"];
  };
}
