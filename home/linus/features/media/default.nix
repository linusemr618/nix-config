{pkgs, ...}: {
  imports = [
  ];

  home.packages = with pkgs; [
    makemkv
    spotify
    vlc
  ];
}
