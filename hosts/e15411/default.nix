{
  imports = [
    ./hardware-configuration.nix
    ../common/global
    ../common/users/linus
  ];
  
  networking.hostName = "nix-e15411";
  
  # Enable SOPS for WiFi password management
  networking.wireless.sops.enable = true;
  
  system.stateVersion = "25.11";
}
