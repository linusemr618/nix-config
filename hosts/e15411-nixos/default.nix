{
  imports = [
    ./hardware-configuration.nix
    ../common/global
    ../common/users/linus
  ];

  networking.hostName = "e15411-nixos";

  system.stateVersion = "25.11";
}
