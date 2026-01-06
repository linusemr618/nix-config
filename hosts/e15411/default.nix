# Host configuration for nix-e15411 (ThinkPad E15)
{
  imports = [
    # Hardware-specific configuration (auto-generated)
    ./hardware-configuration.nix
    
    # Global settings applied to all hosts
    ../common/global
    
    # User configuration with home-manager
    ../common/users/linus
    
    # Optional features (uncomment as needed):
    # ../common/optional/development.nix
    # ../common/optional/gaming.nix
    # ../common/optional/virtualization.nix
    # ../common/optional/media.nix
  ];
  
  # Set the hostname for this machine
  networking.hostName = "nix-e15411";
  
  # NixOS version when this system was first installed
  # Do not change this value after initial installation
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.11";
}
