{
  flake.nixosModules.desktopGnome = {
    services.displayManager.gdm.enable = true;
    services.displayManager.autoLogin.enable = true;
    services.displayManager.autoLogin.user = "linus";
    services.desktopManager.gnome.enable = true;
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
