{
  pkgs,
  ...
}: {
  imports = [
    ./gnome
  ];

  home.packages = with pkgs; [
    geogebra6
    gnome-boxes
    jetbrains.pycharm
    makemkv
    proton-pass
    protonmail-desktop
    vlc
  ];
}
