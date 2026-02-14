{
  services.openssh = {
    enable = true;
    
    settings = {
      # Security: forbid root login through SSH
      PermitRootLogin = "no";
      
      # Security: use keys only, no password authentication
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      
      # Only allow specific authentication methods
      AuthenticationMethods = "publickey";
      
      # Disable empty passwords
      PermitEmptyPasswords = false;
      
      # Security: disable X11 forwarding by default
      X11Forwarding = false;
      
      # Use stronger ciphers and MACs
      Ciphers = [
        "chacha20-poly1305@openssh.com"
        "aes256-gcm@openssh.com"
        "aes128-gcm@openssh.com"
        "aes256-ctr"
        "aes192-ctr"
        "aes128-ctr"
      ];
      
      Macs = [
        "hmac-sha2-512-etm@openssh.com"
        "hmac-sha2-256-etm@openssh.com"
        "hmac-sha2-512"
        "hmac-sha2-256"
      ];
      
      KexAlgorithms = [
        "curve25519-sha256"
        "curve25519-sha256@libssh.org"
        "diffie-hellman-group-exchange-sha256"
      ];
      
      # Increase security
      MaxAuthTries = 3;
      LoginGraceTime = 30;
      
      # Performance: enable compression
      Compression = true;
    };
    
    # Enable key-based authentication
    openFirewall = true;
  };
  
  # Fail2ban for additional security
  services.fail2ban = {
    enable = true;
    maxretry = 3;
    ignoreIP = [
      "127.0.0.1/8"
      "::1"
    ];
  };
}
