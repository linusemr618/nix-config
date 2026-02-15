{pkgs, ...}: let
  extensions = with pkgs.gnomeExtensions; [
    appindicator
    blur-my-shell
    caffeine
    clipboard-indicator
    dash-to-dock
    gsconnect
  ];
in {
  programs.gnome-shell.extensions = map (i: {package = i;}) extensions;

  dconf.settings = {
    "org/gnome/shell/extensions/caffeine" = {
      enable-mpris = true;
      nightlight-control = "always";
      show-notifications = false;
      toggle-shortcut = ["<Super>c"];
    };
  };
}
