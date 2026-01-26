{
  pkgs,
  ...
}: {
  imports = [
    ./git.nix
    ./neovim.nix
  ];

  home.packages = with pkgs; [
    android-tools
    python3
  ];
}
