{lib, ...}: {
  dconf.settings = {
    "org/gnome/desktop/notifications".show-in-lock-screen = false;
    "org/gnome/desktop/peripherals/mouse".speed = -0.75;
    "org/gnome/desktop/privacy" = {
      recent-files-max-age = 30;
      remove-old-temp-files = true;
      remove-old-trash-files = true;
    };
    "org/gnome/desktop/screensaver".lock-delay = lib.hm.gvariant.mkUint32 60;
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = true;
      night-light-temperature = lib.hm.gvariant.mkUint32 3700;
    };
    "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"];
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "kgx";
      name = "Launch Console";
    };
    "org/gnome/system/location".enabled = true;

    "org/gnome/nautilus/list-view" = {
      default-zoom-level = "small";
      use-tree-view = true;
    };
    "org/gnome/nautilus/preferences" = {
      recursive-search = "always";
      default-folder-viewer = "list-view";
      show-create-link = true;
    };
  };
}
