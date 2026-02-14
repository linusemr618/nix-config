{ lib, ... }: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    
    settings = {
      # Prompt format
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$nix_shell"
        "$python"
        "$nodejs"
        "$rust"
        "$golang"
        "$docker_context"
        "$line_break"
        "$character"
      ];
      
      # Right prompt
      right_format = "$time";
      
      # Add newline between prompts
      add_newline = true;
      
      # Character
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
        vimcmd_symbol = "[←](bold green)";
      };
      
      # Directory
      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
        style = "bold cyan";
      };
      
      # Git
      git_branch = {
        symbol = " ";
        style = "bold purple";
      };
      
      git_status = {
        conflicted = "🏳";
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        untracked = "🤷";
        stashed = "📦";
        modified = "📝";
        staged = "[++($count)](green)";
        renamed = "👅";
        deleted = "🗑";
      };
      
      # Nix shell
      nix_shell = {
        disabled = false;
        format = "via [$symbol$state]($style) ";
        symbol = "❄️ ";
        pure_msg = "pure";
        impure_msg = "impure";
        unknown_msg = "unknown";
      };
      
      # Programming languages
      python = {
        symbol = " ";
        format = "via [\${symbol}\${pyenv_prefix}(\${version} )(\\($virtualenv\\) )]($style)";
      };
      
      nodejs = {
        symbol = " ";
      };
      
      rust = {
        symbol = " ";
      };
      
      golang = {
        symbol = " ";
      };
      
      # Time
      time = {
        disabled = false;
        format = "[$time]($style)";
        time_format = "%T";
        style = "bold white";
      };
      
      # Username
      username = {
        show_always = false;
        format = "[$user]($style)@";
      };
      
      # Hostname
      hostname = {
        ssh_only = true;
        format = "[$hostname]($style):";
      };
    };
  };
}
