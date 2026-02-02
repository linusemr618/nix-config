{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    systems.url = "github:nix-systems/default";
  };

  outputs = {
    nixpkgs,
    systems,
    ...
  }: let 
    forEachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f pkgsFor.${system});
    pkgsFor = nixpkgs.lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
    pythonEnv = pkgs.python3.withPackages (p: with p; [
      
    ]);
  in {
    devShells = forEachSystem (pkgs: {
      default = pkgs.mkShell {
        packages = [
          pythonEnv
        ];
      };
    });
  };
}