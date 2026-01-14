{
  imports = [
    ./hardware-configuration.nix
    ../common/global
    ../common/users/linus
  ];
  
  networking.hostName = "nix-e15411";

  boot.kernelParams = [ "acpi_osi=\"Windows 2020\"" ];
  
  system.stateVersion = "25.11";
}
