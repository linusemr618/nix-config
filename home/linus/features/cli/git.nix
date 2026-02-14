{ pkgs, ... }: {
  programs.git = {
    enable = true;
    
    userName = "Linus Emmerich";
    userEmail = "emmerichlinus@gmail.com";
    
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      
      # Better diff algorithm
      diff.algorithm = "histogram";
      
      # Reuse recorded resolution
      rerere.enabled = true;
      
      # Push settings
      push = {
        default = "current";
        autoSetupRemote = true;
      };
      
      # Merge settings
      merge.conflictstyle = "zdiff3";
      
      # Better commit message editing
      commit.verbose = true;
      
      # Column output for better readability
      column.ui = "auto";
      
      # Branch sorting
      branch.sort = "-committerdate";
      
      # Credential helper
      credential.helper = "store";
    };
    
    aliases = {
      # Quick commands
      st = "status -sb";
      co = "checkout";
      br = "branch";
      ci = "commit";
      unstage = "reset HEAD --";
      
      # Log aliases
      lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      last = "log -1 HEAD --stat";
      
      # Amend
      amend = "commit --amend --no-edit";
      
      # Show what's changed
      changed = "diff --name-only";
      
      # Find commits by message
      find = "log --all --oneline --graph --decorate";
    };
    
    ignores = [
      # Editor files
      "*~"
      "*.swp"
      "*.swo"
      ".vscode/"
      ".idea/"
      
      # OS files
      ".DS_Store"
      "Thumbs.db"
      
      # Build artifacts
      "result"
      "result-*"
      
      # Direnv
      ".direnv/"
      ".envrc"
    ];
    
    delta = {
      enable = true;
      options = {
        features = "decorations";
        navigate = true;
        light = false;
        side-by-side = true;
      };
    };
  };
}
