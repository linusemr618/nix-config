{pkgs, ...}: {
  imports = [
    ./brave.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    discord
    jetbrains.pycharm
    makemkv
    plex-desktop
    proton-pass
    protonmail-desktop
    spotify
    vlc
  ];
}
