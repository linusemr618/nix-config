{ ... }: {
  # System-wide environment variables
  environment.variables = {
    # Editor
    EDITOR = "nvim";
    VISUAL = "nvim";
    
    # Pager
    PAGER = "less";
    LESS = "-R";
    
    # XDG directories (ensure they're set)
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_CACHE_HOME = "$HOME/.cache";
  };
  
  # Session variables
  environment.sessionVariables = {
    # Disable telemetry
    DO_NOT_TRACK = "1";
    DOTNET_CLI_TELEMETRY_OPTOUT = "1";
    
    # Improve some tools
    BAT_THEME = "TwoDark";
  };
}
