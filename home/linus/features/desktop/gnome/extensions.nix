{
  pkgs,
  ...
}: let
  extensions = with pkgs.gnomeExtensions; [
    caffeine
    dash-to-dock
  ];
in {
  home.packages = extensions;

  dconf.settings = {
    "org/gnome/shell".enabled-extensions = map (i: i.extensionUuid) extensions;
    
    "org/gnome/shell/extensions/caffeine" = {
      enable-mpris = true;
      nightlight-control = "always";
      show-notifications = false;
      toggle-shortcut = [ "<Super>c" ];
    };
  };
}