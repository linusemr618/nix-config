{
  flake.nixosModules.desktopNiri = {
    config,
    pkgs,
    ...
  }: {
    programs = {
      niri = {
        enable = true;
        useNautilus = true;
      };
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
      ];
    };
    hardware.bluetooth.enable = true;
    security = {
      pam.services.greetd.enableGnomeKeyring = true;
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
      power-profiles-daemon.enable = true;
      upower.enable = true;
    };
    systemd.user.services.niri.enableDefaultPath = false;
    xdg.portal.config.niri = {
      "org.freedesktop.impl.portal.FileChooser" = ["gtk"]; # or "kde"
    };
  };

  flake.homeModules.desktopNiri = {pkgs, ...}: {
    programs = {
      fuzzel.enable = true;
    };
    home.packages = with pkgs; [
      kitty
      swayidle
    ];
  };
}
