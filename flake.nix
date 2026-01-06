{
  description = "NixOS configuration with flakes and home-manager";

  inputs = {
    # Nixpkgs stable (25.11 release)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    
    # Nixpkgs unstable for bleeding-edge packages
    # Access via pkgs.unstable.<package> (see overlays/default.nix)
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager - matches nixpkgs version
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    # Add more inputs here as needed:
    # hardware.url = "github:nixos/nixos-hardware";
    # agenix.url = "github:ryantm/agenix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    # Systems supported by this flake
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    
    # Helper to generate attributes for all systems
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Custom packages from ./pkgs
    # Build with: nix build .#package-name
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    
    # Code formatter for nix files
    # Format with: nix fmt
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Overlays for custom and modified packages
    overlays = import ./overlays {inherit inputs;};
    
    # Reusable NixOS modules
    nixosModules = import ./modules/nixos;
    
    # Reusable home-manager modules
    homeManagerModules = import ./modules/home-manager;

    # NixOS system configurations
    # Build with: nixos-rebuild switch --flake .#hostname
    nixosConfigurations = {
      nix-e15411 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/e15411
        ];
      };
      
      # Add more hosts here:
      # another-host = nixpkgs.lib.nixosSystem {
      #   specialArgs = {inherit inputs;};
      #   modules = [./hosts/another-host];
      # };
    };

    # Standalone home-manager configuration (alternative to NixOS module integration)
    # Activate with: home-manager switch --flake .#username@hostname
    # Currently disabled in favor of NixOS module integration
    # Uncomment and configure if you want standalone home-manager:
    #
    # homeConfigurations = {
    #   "linus@nix-e15411" = home-manager.lib.homeManagerConfiguration {
    #     pkgs = nixpkgs.legacyPackages.x86_64-linux;
    #     extraSpecialArgs = {inherit inputs;};
    #     modules = [./home/linus];
    #   };
    # };
  };
}
