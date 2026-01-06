# SSH server configuration
{
  services.openssh = {
    enable = true;
    settings = {
      # Security: Forbid root login through SSH
      PermitRootLogin = "no";
      
      # Security: Use SSH keys only (disable password authentication)
      # Change to true if you need password authentication
      PasswordAuthentication = false;
    };
  };
  
  # Optional: Configure SSH port
  # services.openssh.ports = [ 22 ];
}
