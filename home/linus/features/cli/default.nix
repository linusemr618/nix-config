{pkgs, ...}: {
  imports = [
    ./direnv.nix
    ./fish.nix
    ./git.nix
    ./neovim.nix
    #./python.nix
  ];

  home.packages = with pkgs; [
    alejandra
    android-tools
    devenv
  ];
}
