{ pkgs, lib, ... }: {
  programs.fish = {
    enable = true;
    
    # Fish abbreviations (these expand as you type, better than aliases for Fish)
    shellAbbrs = {
      # Git
      g = "git";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";
      gd = "git diff";
      gco = "git checkout";
      
      # NixOS
      nr = "sudo nixos-rebuild switch --flake .";
      nrt = "sudo nixos-rebuild test --flake .";
      hm = "home-manager switch --flake .";
      nfu = "nix flake update";
      nfc = "nix flake check";
      nfmt = "alejandra .";
      
      # System
      update = "sudo nixos-rebuild switch --flake . && home-manager switch --flake .";
      cleanup = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
    };
    
    functions = {
      # Create and enter directory
      mkcd = "mkdir -p $argv[1]; and cd $argv[1]";
      
      # Git commit with message
      gcm = "git commit -m $argv";
      
      # Quick backup
      backup = "cp $argv[1] $argv[1].bak";
      
      # Extract any archive
      extract = ''
        if test -f $argv[1]
          switch $argv[1]
            case '*.tar.bz2'
              tar xjf $argv[1]
            case '*.tar.gz'
              tar xzf $argv[1]
            case '*.bz2'
              bunzip2 $argv[1]
            case '*.rar'
              unrar x $argv[1]
            case '*.gz'
              gunzip $argv[1]
            case '*.tar'
              tar xf $argv[1]
            case '*.tbz2'
              tar xjf $argv[1]
            case '*.tgz'
              tar xzf $argv[1]
            case '*.zip'
              unzip $argv[1]
            case '*.Z'
              uncompress $argv[1]
            case '*.7z'
              7z x $argv[1]
            case '*'
              echo "'$argv[1]' cannot be extracted via extract"
          end
        else
          echo "'$argv[1]' is not a valid file"
        end
      '';
    };
    
    interactiveShellInit = ''
      # Disable greeting
      set fish_greeting
      
      # Vi mode
      fish_vi_key_bindings
      
      # Set color scheme
      set -g fish_color_command green
      set -g fish_color_error red
      set -g fish_color_param cyan
    '';
    
    plugins = [
      {
        name = "tide";
        src = pkgs.fetchFromGitHub {
          owner = "IlanCosman";
          repo = "tide";
          rev = "v6.0.1";
          sha256 = "sha256-oLD7gYFCIeIzBeAW1j62z5FnzWAp3xSfxxe7kBtRUAo=";
        };
      }
      {
        name = "autopair";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "autopair.fish";
          rev = "4d1752ff5b39819ab58d7337c69220342e9de0e2";
          sha256 = "sha256-qt3t1iKRRNuiLWiVoiAYOu+9E7jsyECyIqZJ/oRIT1A=";
        };
      }
    ];
  };
  
  # Make fish the default shell
  programs.bash = {
    enable = true;
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        exec ${pkgs.fish}/bin/fish
      fi
    '';
  };
}
