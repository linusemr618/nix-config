{
  imports = [
    ./hardware-configuration.nix
    ../common/global
    ../common/users/linus
  ];
  
  networking.hostName = "nix-e15411";

  boot.kernelParams = [
    "acpi_osi=!"
    "acpi_osi=\"WWindows 2022\""
  ];
  
  system.stateVersion = "25.11";
}
