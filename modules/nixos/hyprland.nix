{ inputs, lib, config, pkgs, ... }:

{
  options.modules.hyprland.enable = lib.mkEnableOption "Hyprland window manager";

  config = lib.mkIf config.modules.hyprland.enable {
    # Enable Hyprland
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland.enable = true;
    };

    # Enable polkit for authentication
    security.polkit.enable = true;

    # Enable XDG portal for screen sharing and other features
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };

    # Enable sound with PipeWire
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # Enable dbus
    services.dbus.enable = true;

    # Enable greetd display manager with tuigreet
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
          user = "greeter";
        };
      };
    };

    # Essential packages for Hyprland
    environment.systemPackages = with pkgs; [
      # Wayland utilities
      wayland
      wayland-utils
      wayland-protocols
      wl-clipboard

      # Graphics and display
      mesa
      vulkan-loader
      vulkan-tools

      # Authentication agent
      polkit_gnome

      # Screenshot and recording
      grim
      slurp
      wf-recorder

      # Notifications
      libnotify

      # File managers
      xfce.thunar
      xfce.thunar-volman
      gvfs

      # System utilities
      brightnessctl
      playerctl
      pavucontrol
    ];

    # Enable OpenGL
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    # Set environment variables
    environment.sessionVariables = {
      # Hint electron apps to use Wayland
      NIXOS_OZONE_WL = "1";
      # Set XDG directories
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
    };

    # Add user to video group for brightness control
    users.users = lib.mkIf (config.users.users ? your-username) {
      your-username.extraGroups = [ "video" ];
    };
  };
}
