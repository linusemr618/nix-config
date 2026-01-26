{
  inputs,
  pkgs,
  ...
}: {
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
      pkgs = pkgs.unstable;
    };
  };
}