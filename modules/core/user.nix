{inputs, ...}: {
  flake.nixosModules.core = {config, ...}: {
    imports = [inputs.home-manager.nixosModules.home-manager];
    users.users.${config.user.name} = {
      isNormalUser = true;
      description = config.user.description;
      extraGroups = ["networkmanager" "wheel"];
    };
    home-manager = {
      backupFileExtension = "backup";
      useUserPackages = true;
      useGlobalPkgs = true;
    };
  };

  flake.homeModules.core = {config, ...}: {
    home = {
      username = config.user.name;
      homeDirectory = "/home/${config.home.username}";
      stateVersion = "26.05";
    };
    systemd.user.startServices = "sd-switch";
  };
}
