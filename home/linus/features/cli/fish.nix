{pkgs, ...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting # Disable greeting
    '';
    plugins = [
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
    ];
    functions = {
      gu = "git pull && git add . && git commit -am 'update' && git push";
      nfu = "pushd ~/nix-config && nix flake update && popd";
      nrs = "pushd ~/nix-config && git add . && sudo nixos-rebuild switch --flake . && popd";
      run = "NIXPKGS_ALLOW_UNFREE=1 nix run --impure nixpkgs#$argv";
      update = "nfu && nrs";
    };
  };

  home.packages = with pkgs; [
    fzf
    grc
  ];
}
