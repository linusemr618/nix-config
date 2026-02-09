{ pkgs, ... }: {
  imports = [
    ./git.nix
    ./neovim.nix
    ./python.nix
  ];

  home.packages = with pkgs; [
    android-tools
    devenv
  ];
}