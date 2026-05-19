{
  flake.nixosModules.desktopNiri = {
    config,
    pkgs,
    ...
  }: {
    programs = {
      niri.enable = true;
      #waybar.enable = true;
    };
    environment = {
      sessionVariables.NIXOS_OZONE_WL = "1";
      systemPackages = with pkgs; [
        /*
          alacritty
        fuzzel
        swaylock
        mako
        swayidle
        */
        xwayland-satellite
        noctalia-shell
      ];
    };
    security = {
      pam.services.swaylock = {};
      polkit.enable = true;
    };
    services = {
      gnome.gnome-keyring.enable = true;
      greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${config.programs.niri.package}/bin/niri-session";
            user = "${config.user.name}";
          };
        };
      };
    };
    systemd.user.services.niri.enableDefaultPath = false;
    xdg.portal.config.niri = {
      "org.freedesktop.impl.portal.FileChooser" = ["gtk"]; # or "kde"
    };
  };

  flake.homeModules.desktopNiri = {
    programs.niri = {
      enable = true;
      settings = {
        # Autostart your desktop shell
        spawn-at-startup = [
          {command = ["noctalia-shell"];}
          {command = ["xwayland-satellite"];}
        ];
      };
    };
  };
}
