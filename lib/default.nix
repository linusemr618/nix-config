{ lib, inputs, ... }: rec {
  # Create a NixOS system configuration with common settings
  mkSystem = {
    hostname,
    system ? "x86_64-linux",
    modules ? [],
  }: inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [
      ../hosts/${hostname}
    ] ++ modules;
  };

  # Helper to create an attribute set from a directory
  mapModules = dir: fn:
    lib.pipe dir [
      builtins.readDir
      (lib.filterAttrs (name: type:
        type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix"
      ))
      (lib.mapAttrs' (name: _: {
        name = lib.removeSuffix ".nix" name;
        value = fn (dir + "/${name}");
      }))
    ];

  # Import all .nix files in a directory as a list
  mapModulesAsList = dir:
    lib.pipe dir [
      builtins.readDir
      (lib.filterAttrs (name: type:
        type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix"
      ))
      (lib.mapAttrsToList (name: _: dir + "/${name}"))
    ];

  # Helper for enabled features
  enabled = { enable = true; };
  
  # Helper for disabled features
  disabled = { enable = false; };
}
