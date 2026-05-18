{
  flake.nixosModules.desktopNiri = {
    config,
    pkgs,
    ...
  }: {
    programs = {
      niri.enable = true;
      waybar.enable = true;
    };
    environment = {
      sessionVariables.NIXOS_OZONE_WL = "1";
      systemPackages = with pkgs; [
        alacritty
        fuzzel
        swaylock
        mako
        swayidle
        xwayland-satellite
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
  };

  flake.homeModules.desktopNiri = {pkgs, ...}: {
  };
}
