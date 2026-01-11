{
  pkgs,
  ...
}: {
  imports = [
    ./brave.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    gnome-boxes
    jetbrains.pycharm
    python3
  ];
}
