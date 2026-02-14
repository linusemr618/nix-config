{
  boot.loader = {
    systemd-boot = {
      enable = true;
      # Limit number of generations to keep
      configurationLimit = 10;
      # Enable boot editor
      editor = false;  # Security: disable editing boot options
      # Faster boot menu timeout
      timeout = 3;
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };
  
  # Silent boot for cleaner experience
  boot.kernelParams = [
    "quiet"
    "splash"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];
  
  # Plymouth for boot splash
  boot.plymouth.enable = true;
}
