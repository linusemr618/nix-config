{
  imports = [
    ./hardware-configuration.nix
    ../common/global
    ../common/users/linus
  ];
  
  networking.hostName = "e15411-nixos";

  #boot.kernelParams = [
  #  "acpi_osi=\"Windows 2015\""
  #];
  
  system.stateVersion = "25.11";
}
