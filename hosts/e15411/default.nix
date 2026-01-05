{
  imports = [
    ./hardware-configuration.nix
    ../common/global
    ../common/users/linus
  ];
  
  networking.hostName = "nix-e15411";
  
  system.stateVersion = "25.11";
}
