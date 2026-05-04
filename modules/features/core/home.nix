{inputs, ...}: {
  flake.nixosModules.core = {
    imports = [inputs.home-manager.nixosModules.home-manager];
    home-manager = {
      backupFileExtension = "backup";
      useUserPackages = true;
      useGlobalPkgs = true;
    };
  };
}
