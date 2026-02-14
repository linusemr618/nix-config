{ lib, ... }: {
  dconf.settings = {
    # Desktop behavior
    "org/gnome/desktop/notifications".show-in-lock-screen = false;
    "org/gnome/desktop/screensaver".lock-delay = lib.hm.gvariant.mkUint32 60;
    
    # Mouse settings
    "org/gnome/desktop/peripherals/mouse" = {
      speed = -0.75;
      accel-profile = "flat";  # Disable mouse acceleration
    };
    
    # Touchpad settings  
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      natural-scroll = true;
      two-finger-scrolling-enabled = true;
    };
    
    # Privacy settings
    "org/gnome/desktop/privacy" = {
      recent-files-max-age = 30;
      remove-old-trash-files = true;
      remove-old-temp-files = true;
      old-files-age = lib.hm.gvariant.mkUint32 30;
    };
    
    # Night light
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = true;
      night-light-temperature = lib.hm.gvariant.mkUint32 3700;
    };
    
    # Location services
    "org/gnome/system/location".enabled = true;

    # Nautilus (file manager) settings
    "org/gnome/nautilus/list-view" = {
      default-zoom-level = "small";
      use-tree-view = true;
    };
    "org/gnome/nautilus/preferences" = {
      recursive-search = "always";
      default-folder-viewer = "list-view";
      show-create-link = true;
      show-delete-permanently = true;
    };
    
    # Window management
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      resize-with-right-button = true;
      focus-mode = "click";
    };
    
    # Keyboard shortcuts
    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      toggle-fullscreen = [ "<Super>f" ];
      toggle-maximized = [ "<Super>m" ];
    };
    
    # Interface settings
    "org/gnome/desktop/interface" = {
      clock-show-weekday = true;
      show-battery-percentage = true;
      enable-hot-corners = false;
    };
    
    # Power settings
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-timeout = 3600;  # 1 hour on AC
      sleep-inactive-battery-timeout = 900;  # 15 min on battery
      power-button-action = "interactive";
    };
  };
}
