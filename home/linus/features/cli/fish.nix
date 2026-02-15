{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting # Disable greeting
    '';
    plugins = [
      { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
    ];
    shellAbbrs = {
      gcp = "git add . && git commit -am 'update' && git push";
      nfu = "nix flake update";
      nrs = "git add . && sudo nixos-rebuild switch --flake .";
      update = "nix flake update && git add . && sudo nixos-rebuild switch --flake .";
    };
  };

  home.packages = with pkgs; [
    fzf
    grc
  ];
}