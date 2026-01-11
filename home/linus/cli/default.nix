{
  pkgs,
  ...
}: {
  imports = [
    ./git.nix
    ./home-manager.nix
    ./neovim.nix
  ];

  home.packages = with pkgs; [

  ];
}
