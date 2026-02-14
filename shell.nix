{ pkgs ? import <nixpkgs> {}, ... }: {
  default = pkgs.mkShell {
    name = "nix-config";
    
    NIX_CONFIG = "extra-experimental-features = nix-command flakes ca-derivations";
    
    nativeBuildInputs = with pkgs; [
      # Version control
      git
      
      # Nix tooling
      alejandra  # Nix formatter
      nil        # Nix language server
      nix-tree   # Inspect dependency trees
      
      # System management
      home-manager
      
      # Utilities
      jq         # JSON processing
      yq         # YAML processing
    ];
    
    shellHook = ''
      echo "🚀 NixOS configuration development environment"
      echo ""
      echo "Available commands:"
      echo "  alejandra .          - Format all Nix files"
      echo "  nix flake check      - Validate flake"
      echo "  nix flake update     - Update flake inputs"
      echo "  sudo nixos-rebuild switch --flake .#e15411-nixos"
      echo "  home-manager switch --flake .#linus@e15411-nixos"
      echo ""
    '';
  };
}