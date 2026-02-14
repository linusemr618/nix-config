{
  config,
  inputs,
  lib,
  ...
}: let
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in {
  nixpkgs = {
    overlays = builtins.attrValues inputs.self.overlays;
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      # Enable flakes and nix-command
      experimental-features = [ "nix-command" "flakes" ];
      
      # Optimize storage
      auto-optimise-store = true;
      
      # Don't warn about dirty git trees
      warn-dirty = false;
      
      # Build settings
      max-jobs = "auto";
      cores = 0;  # Use all available cores
      
      # Substituter settings for faster builds
      builders-use-substitutes = true;
      
      # Trust settings for user convenience
      trusted-users = [ "root" "@wheel" ];
      
      # Keep build logs
      keep-outputs = true;
      keep-derivations = true;
      
      # Use flakes for nix-path and registry
      flake-registry = "";
      nix-path = config.nix.nixPath;
    };

    # Garbage collection
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
      persistent = true;
    };

    # Optimize store regularly
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };

    # Disable channels, we're all-in on flakes
    channel.enable = false;
    
    # Set up registry to use our flake inputs
    registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };
}
