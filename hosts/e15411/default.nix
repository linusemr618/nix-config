{
  imports = [
    ./hardware-configuration.nix
    ../common/global
    ../common/users/linus
  ];
  
  networking.hostName = "nix-e15411";
  
  # Enable SOPS for WiFi password management
  networking.wireless.sops = {
    enable = true;
    # Uncomment and add your WiFi networks here
    # networks = ["home_network" "work_network"];
  };
  
  system.stateVersion = "25.11";
}
