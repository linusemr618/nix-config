{
  flake.nixosModules.desktop = {
    services.displayManager.gdm.enable = true;
    services.displayManager.autoLogin.enable = true;
    services.displayManager.autoLogin.user = "linus";
    services.desktopManager.gnome.enable = true;
  };

  flake.homeModules.desktop = {
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
