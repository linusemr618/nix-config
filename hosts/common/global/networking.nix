{ pkgs, ... }: {
  networking = {
    # NetworkManager for easy network management
    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openconnect
        networkmanager-openvpn
      ];
      wifi = {
        powersave = true;
        backend = "wpa_supplicant";
      };
    };
    
    # Enable firewall
    firewall = {
      enable = true;
      allowPing = false;  # Don't respond to pings for better privacy
      logRefusedConnections = false;  # Reduce log noise
    };
    
    # Disable IPv6 if not needed (uncomment if you don't use IPv6)
    # enableIPv6 = false;
  };
  
  # DNS configuration
  services.resolved = {
    enable = true;
    dnssec = "allow-downgrade";
    fallbackDns = [
      "1.1.1.1"  # Cloudflare
      "8.8.8.8"  # Google
    ];
  };
}
