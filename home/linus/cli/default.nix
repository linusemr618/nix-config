{
  pkgs,
  ...
}: {
  imports = [
    ./git.nix
    ./neovim.nix
  ];

  home.packages = with pkgs; [
    python3
  ];
}
