{
  inputs,
  outputs,
  #pkgs,
  ...
}: {
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    backupFileExtension = "backup";
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs outputs;
      #pkgs = pkgs.unstable;
    };
  };
}