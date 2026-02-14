{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../features/cli
    ../features/desktop/gnome
    ../features/dev
    ../features/media
    ../features/productivity
    ../features/utils
  ]
  ++ (builtins.attrValues inputs.self.homeManagerModules);

  home = {
    username = "linus";
    homeDirectory = "/home/linus";
    
    # Session variables
    sessionVariables = {
      # Default applications
      EDITOR = "nvim";
      VISUAL = "nvim";
      BROWSER = "brave";
      TERMINAL = "gnome-terminal";
      
      # XDG directories
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_STATE_HOME = "$HOME/.local/state";
      
      # FZF configuration
      FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --border";
      
      # Less configuration
      LESS = "-R";
      LESSHISTFILE = "-";  # Don't save less history
      
      # Privacy
      DO_NOT_TRACK = "1";
    };
  };

  # Add some useful packages at the global level
  home.packages = with pkgs; [
    # Archive tools
    unzip
    zip
    p7zip
    unrar
    
    # Network tools
    wget
    curl
    
    # File utilities
    file
    tree
    
    # System utilities
    htop
    lsof
  ];

  # Enable home-manager
  programs.home-manager.enable = true;
  
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
  
  home.stateVersion = "25.11";
}
