# Boot loader configuration
{
  # Use systemd-boot as the bootloader
  boot.loader.systemd-boot.enable = true;
  
  # Allow modification of EFI variables (required for systemd-boot)
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Optional: Limit number of generations in boot menu
  # boot.loader.systemd-boot.configurationLimit = 10;
}
