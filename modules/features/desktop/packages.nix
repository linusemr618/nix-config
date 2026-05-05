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
      gnome-tweaks
      jetbrains.pycharm
      plex-desktop
      proton-pass
      proton-vpn
      protonmail-desktop
      spotify
      vlc
    ];
  };
}
