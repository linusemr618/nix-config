{
  flake.nixosModules.core = {pkgs, ...}: {
    programs.fish.enable = true;
    programs.bash = {
      interactiveShellInit = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };
  };

  flake.homeModules.core = {pkgs, ...}: {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_greeting # Disable greeting
      '';
      plugins = with pkgs.fishPlugins; [
        {
          name = "fzf-fish";
          src = fzf-fish.src;
        }
        {
          name = "forgit";
          src = forgit.src;
        }
        {
          name = "done";
          src = done.src;
        }
        {
          name = "hydro";
          src = hydro.src;
        }
        {
          name = "grc";
          src = grc.src;
        }
        {
          name = "colored-man-pages";
          src = colored-man-pages.src;
        }
        {
          name = "z";
          src = z.src;
        }
      ];
      functions = {
        gu = "git pull && git add . && git commit -m 'update $(date -u --iso-8601=seconds)' && git push";
        nfu = "pushd ~/nix-config && nix flake update && popd";
        nrs = "pushd ~/nix-config && git add . && sudo nixos-rebuild switch --flake . && popd";
        run = "NIXPKGS_ALLOW_UNFREE=1 nix run --impure nixpkgs#$argv";
        shell = "NIXPKGS_ALLOW_UNFREE=1 nix shell --impure (string replace -r '^' 'nixpkgs#' $argv) -c fish";
        update = "nfu && nrs";
      };
    };

    home.packages = with pkgs; [
      fzf
      grc
    ];
  };
}
