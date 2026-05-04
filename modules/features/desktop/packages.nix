{
  flake.nixosModules.desktop = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      gparted
    ];
  };

  flake.homeModules.desktop = {pkgs, ...}: {
    home.packages = with pkgs; [
      dconf-editor
      fractal
      gnome-boxes
      gnome-tweaks
      jetbrains.pycharm
      plex-desktop
      protonmail-desktop
      spotify
      vlc
    ];
  };
}
