# Development environment configuration
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Version control
    git
    git-lfs
    
    # Build tools
    gnumake
    gcc
    cmake
    
    # Editors (system-wide, can also be in home-manager)
    vim
    
    # Container tools
    docker-compose
  ];
  
  # Enable direnv for per-project environments
  programs.direnv.enable = true;
  
  # Optional: Enable Docker (uncomment if needed)
  # virtualisation.docker.enable = true;
  # users.users.linus.extraGroups = [ "docker" ];
}
