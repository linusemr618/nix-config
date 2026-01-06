# Gaming configuration
{pkgs, ...}: {
  # Enable 32-bit support for games
  hardware.graphics.enable32Bit = true;
  
  # Enable Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
  
  # Gaming-related packages
  environment.systemPackages = with pkgs; [
    # Lutris for non-Steam games
    lutris
    
    # Wine for Windows games
    wineWowPackages.stable
    winetricks
    
    # Game launchers
    # heroic  # Epic Games, GOG
    # bottles # Wine prefix manager
  ];
  
  # Optional: Enable GameMode for performance
  programs.gamemode.enable = true;
}
