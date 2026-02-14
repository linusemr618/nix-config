{ pkgs, ... }: let
  extensions = with pkgs.gnomeExtensions; [
    # System indicators
    appindicator
    
    # Aesthetics
    blur-my-shell
    
    # Productivity
    caffeine
    clipboard-indicator
    dash-to-dock
    
    # Connectivity
    gsconnect
    
    # Window management
    #window-list  # Uncomment if needed
  ];
in {
  programs.gnome-shell.extensions = map (i: { package = i; }) extensions;

  dconf.settings = {
    # Caffeine settings
    "org/gnome/shell/extensions/caffeine" = {
      enable-fullscreen = true;
      restore-state = true;
      show-indicator = "always";
      show-notifications = false;
      toggle-shortcut = [ "<Super>c" ];
    };
    
    # Dash to Dock settings
    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "BOTTOM";
      dock-fixed = false;
      autohide = true;
      intellihide = true;
      intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
      show-mounts = false;
      show-trash = false;
      click-action = "minimize";
      scroll-action = "cycle-windows";
      dash-max-icon-size = 48;
    };
    
    # Blur my Shell settings
    "org/gnome/shell/extensions/blur-my-shell" = {
      brightness = 0.6;
      sigma = 30;
    };
    
    # Clipboard Indicator settings
    "org/gnome/shell/extensions/clipboard-indicator" = {
      toggle-menu = [ "<Super>v" ];
      history-size = 50;
    };
  };
}
