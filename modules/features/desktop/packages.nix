{
  flake.nixosModules.desktop = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      gparted
    ];
  };

  flake.homeModules.desktop = {pkgs, ...}: {
    home.packages = with pkgs; [
      dconf-editor
      gnome-boxes
      gnome-tweaks
      jetbrains.pycharm
      picard
      plex-desktop
      proton-pass
      protonmail-desktop
      spotify
      vlc
    ];
  };
}
