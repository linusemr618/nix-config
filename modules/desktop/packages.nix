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
      geary
      gnome-tweaks
      jetbrains.pycharm
      plex-desktop
      proton-pass
      proton-vpn
      protonmail-desktop
      spotify
      vlc
    ];

    #xdg.configFile."autostart/proton.vpn.app.gtk.desktop".source = "${pkgs.proton-vpn}/share/applications/proton.vpn.app.gtk.desktop";
  };
}
