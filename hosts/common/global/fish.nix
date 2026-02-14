{ pkgs, ... }: {
  # Enable fish system-wide
  programs.fish.enable = true;
  
  # Add fish to /etc/shells
  environment.shells = with pkgs; [ fish ];
  
  # Set fish as default shell for users
  users.defaultUserShell = pkgs.fish;
}
