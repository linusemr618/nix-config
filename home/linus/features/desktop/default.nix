{
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./gnome
  ];

  home.packages = with pkgs; [
    # Stable packages
    geogebra6
    gnome-boxes
    jetbrains.pycharm
    makemkv
    proton-pass
    protonmail-desktop
    vlc
  ] ++ (with pkgs-unstable; [
    # Unstable packages
    # Add packages here that you want from unstable
  ]);
}
