{
  imports = [
    ../common
    
    ./dash-folders.nix
    ./extensions.nix
    ./theme.nix
  ];

  dconf.enable = true;
}