{
  imports = [
    #./dsdt.nix
    ./graphics.nix
    ./hardware-configuration.nix
    #./osi.nix
    ../common/global
    ../common/users/linus
  ];

  networking.hostName = "e15411-nixos";

  system.stateVersion = "25.11";
}
