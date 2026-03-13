{
  description = "My Nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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
    flake-utils,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in {
        packages = import ./pkgs {inherit pkgs;};
        devShells = import ./shell.nix {inherit pkgs;};
        formatter = pkgs.alejandra;
      }
    )
    // {
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;
      overlays = import ./overlays {inherit inputs;};

      nixosConfigurations = {
        "e15411-nixos" = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [./hosts/e15411-nixos];
        };
      };
    };
}
