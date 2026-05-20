{
  flake.nixosModules.desktopGnome = {config, ...}: {
    services.displayManager = {
      gdm.enable = true;
      autoLogin = {
        enable = true;
        user = "${config.user.name}";
      };
    };
    services.desktopManager.gnome.enable = true;
    environment.sessionVariables.NIXOS_OZONE_WL = 1;
  };

  flake.homeModules.desktopGnome = {
    programs.gnome-shell.enable = true;
    dconf.enable = true;

    xdg = {
      enable = true;
      userDirs = {
        enable = true;
        createDirectories = true;
      };
    };
  };
}
