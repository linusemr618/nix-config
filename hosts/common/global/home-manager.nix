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
      # Pass unstable packages as a separate argument so users can choose
      # between stable (pkgs) and unstable (pkgs-unstable) per package
      pkgs-unstable = pkgs.unstable;
    };
  };
}