{pkgs, ...}: {
  imports = [
    ./brave.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    jetbrains.pycharm
    picard
    plex-desktop
    proton-pass
    protonmail-desktop
    spotify
    vlc
  ];
}
