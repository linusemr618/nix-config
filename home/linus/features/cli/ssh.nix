{ ... }: {
  programs.ssh = {
    enable = true;
    
    # Reuse SSH connections for faster repeated connections
    controlMaster = "auto";
    controlPath = "~/.ssh/control-%r@%h:%p";
    controlPersist = "10m";
    
    # Security settings
    hashKnownHosts = true;
    
    extraConfig = ''
      # Use stronger ciphers
      Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr
      
      # Use stronger MACs
      MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256
      
      # Use stronger key exchange
      KexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256
      
      # Prefer public key authentication
      PubkeyAuthentication yes
      
      # Keep connections alive
      ServerAliveInterval 60
      ServerAliveCountMax 3
    '';
    
    matchBlocks = {
      "*" = {
        # Add SSH keys to agent
        addKeysToAgent = "yes";
        
        # Compression for slow connections
        compression = true;
      };
    };
  };
}
