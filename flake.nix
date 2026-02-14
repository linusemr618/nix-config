{
  description = "Linus's opinionated NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (nixpkgs) lib;
    myLib = import ./lib { inherit lib inputs; };
    
    forAllSystems = lib.genAttrs [ "x86_64-linux" "aarch64-linux" ];
  in {
    # Custom library functions
    lib = myLib;
    
    # NixOS configurations
    nixosConfigurations = {
      e15411-nixos = lib.nixosSystem {
        specialArgs = { inherit inputs myLib; };
        modules = [ ./hosts/e15411-nixos ];
      };
    };

    # Reusable modules
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    
    # Overlays
    overlays = import ./overlays { inherit inputs; };
    
    # Per-system outputs
    packages = forAllSystems (system: 
      import ./pkgs { 
        pkgs = import nixpkgs { 
          inherit system;
          config.allowUnfree = true;
        };
      }
    );
    
    devShells = forAllSystems (system: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in import ./shell.nix { inherit pkgs; });
    
    formatter = forAllSystems (system: 
      nixpkgs.legacyPackages.${system}.alejandra
    );
  };
}