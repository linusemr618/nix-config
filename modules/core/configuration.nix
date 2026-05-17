{inputs, ...}: {
  flake.nixosModules.core = {
    config,
    pkgs,
    ...
  }: {
    imports = [inputs.home-manager.nixosModules.home-manager];

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
    services.xserver.xkb = {
      layout = "de";
      variant = "";
    };

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
    # services.openssh.enable = true;

    networking = {
      firewall = {
        allowedTCPPorts = [];
        allowedUDPPorts = [];
      };
      networkmanager = {
        enable = true;
        plugins = with pkgs; [networkmanager-openconnect];
      };
    };

    services = {
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
      printing = {
        enable = true;
        drivers = with pkgs; [
          cups-filters
          cups-browsed
        ];
      };
    };

    users.users.${config.user.name} = {
      isNormalUser = true;
      description = config.user.description;
      extraGroups = ["networkmanager" "wheel"];
      linger = true;
    };
    home-manager = {
      backupFileExtension = "backup";
      useUserPackages = true;
      useGlobalPkgs = true;
    };

    system.stateVersion = "26.05";
  };

  flake.homeModules.core = {config, ...}: {
    home = {
      username = config.user.name;
      homeDirectory = "/home/${config.user.name}";
      stateVersion = "26.05";
    };
    systemd.user.startServices = "sd-switch";
  };
}
