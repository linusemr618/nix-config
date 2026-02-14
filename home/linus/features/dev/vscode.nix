{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    
    extensions = with pkgs.vscode-extensions; [
      # Nix
      jnoortheen.nix-ide
      
      # Python
      ms-python.python
      ms-python.vscode-pylance
      
      # Git
      eamodio.gitlens
      mhutchie.git-graph
      
      # Themes
      catppuccin.catppuccin-vsc
      
      # Utilities
      vscodevim.vim
      editorconfig.editorconfig
      
      # Formatting
      esbenp.prettier-vscode
    ];
    
    userSettings = {
      # Editor settings
      "editor.fontFamily" = "'FiraCode Nerd Font', 'Droid Sans Mono', monospace";
      "editor.fontSize" = 14;
      "editor.fontLigatures" = true;
      "editor.formatOnSave" = true;
      "editor.tabSize" = 2;
      "editor.insertSpaces" = true;
      "editor.rulers" = [ 100 ];
      "editor.renderWhitespace" = "boundary";
      "editor.cursorBlinking" = "smooth";
      "editor.cursorSmoothCaretAnimation" = "on";
      "editor.minimap.enabled" = false;
      "editor.bracketPairColorization.enabled" = true;
      
      # Workbench
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.startupEditor" = "none";
      
      # Files
      "files.autoSave" = "afterDelay";
      "files.trimTrailingWhitespace" = true;
      "files.insertFinalNewline" = true;
      "files.trimFinalNewlines" = true;
      
      # Explorer
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;
      
      # Terminal
      "terminal.integrated.fontFamily" = "'FiraCode Nerd Font'";
      "terminal.integrated.fontSize" = 13;
      "terminal.integrated.defaultProfile.linux" = "fish";
      
      # Git
      "git.autofetch" = true;
      "git.confirmSync" = false;
      "git.enableSmartCommit" = true;
      
      # Nix
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.formatterPath" = "alejandra";
      
      # Python
      "python.languageServer" = "Pylance";
      "python.formatting.provider" = "black";
      "python.linting.enabled" = true;
      "python.linting.pylintEnabled" = true;
      
      # Vim
      "vim.useSystemClipboard" = true;
      "vim.hlsearch" = true;
      "vim.leader" = "<space>";
      
      # Telemetry
      "telemetry.telemetryLevel" = "off";
      
      # Prettier
      "[nix]" = {
        "editor.defaultFormatter" = "jnoortheen.nix-ide";
      };
      "[python]" = {
        "editor.defaultFormatter" = "ms-python.python";
      };
    };
    
    keybindings = [
      {
        key = "ctrl+h";
        command = "workbench.action.navigateLeft";
      }
      {
        key = "ctrl+l";
        command = "workbench.action.navigateRight";
      }
      {
        key = "ctrl+k";
        command = "workbench.action.navigateUp";
      }
      {
        key = "ctrl+j";
        command = "workbench.action.navigateDown";
      }
    ];
  };
  
  # Install fonts for VSCode
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
}
