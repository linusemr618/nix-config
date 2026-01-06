# Nix daemon and flake configuration
{
  config,
  inputs,
  lib,
  ...
}: {
  nixpkgs = {
    # Overlays for custom and unstable packages
    overlays = [
      inputs.self.overlays.additions      # Custom packages from ./pkgs
      inputs.self.overlays.modifications  # Modified existing packages
      inputs.self.overlays.unstable-packages # Access to nixpkgs-unstable
    ];
    
    # Allow unfree packages (e.g., proprietary software)
    config = {
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new nix commands
      experimental-features = "nix-command flakes";
      
      # Disable global flake registry (use flake.lock instead)
      flake-registry = "";
      
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
      
      # Optional: Enable distributed builds
      # trusted-users = [ "root" "@wheel" ];
      
      # Optional: Automatic garbage collection
      # auto-optimise-store = true;
    };
    
    # Disable legacy channels in favor of flakes
    channel.enable = false;

    # Make flake inputs accessible via nix registry and NIX_PATH
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    
    # Optional: Garbage collection settings
    # gc = {
    #   automatic = true;
    #   dates = "weekly";
    #   options = "--delete-older-than 30d";
    # };
  };
}
