{pkgs, ...}: {
  imports = [
  ];

  home.packages = with pkgs; [
    makemkv
    plex-desktop
    spotify
    vlc
  ];
}
