{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.core = {pkgs, ...}: {
    programs.fish = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myFish;
    };
    programs.bash = {
      interactiveShellInit = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${self.packages.${pkgs.stdenv.hostPlatform.system}.myFish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };
  };
  perSystem = {pkgs, ...}: {
    packages.myFish = inputs.wrapper-modules.wrappers.fish.wrap {
      inherit pkgs;
      configFile.content = ''
        set -g fish_greeting
        function run
          NIXPKGS_ALLOW_UNFREE=1 nix run --impure nixpkgs#$argv[1] -- $argv[2..-1]
        end
        function shell
          NIXPKGS_ALLOW_UNFREE=1 nix shell --impure (string replace -r '^' 'nixpkgs#' $argv) -c fish
        end
      '';
      plugins = with pkgs.fishPlugins; [
        fzf-fish
        forgit
        done
        hydro
        grc
        colored-man-pages
        z
      ];
      shellAliases = {
        gu = "git pull && git add . && git commit -m 'update $(date -u --iso-8601=seconds)' && git push";
        nfu = "nix flake update --flake $FLAKE";
        nhs = "nh os switch";
        nhc = "nh clean all";
        update = "nfu && nhs";
      };
    };
  };
}
