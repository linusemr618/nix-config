{inputs, ...}: {
  flake.nixosModules.core = {
    config,
    lib,
    ...
  }: {
    imports = [inputs.nix-index-database.nixosModules.default];

    nixpkgs.config.allowUnfree = true;
    nix = {
      channel.enable = false;
      /*
        gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 7d";
      };
      */
      settings = {
        auto-optimise-store = true;
        experimental-features = [
          "ca-derivations"
          "flakes"
          "nix-command"
        ];
        substituters = ["https://nix-community.cachix.org"];
        trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
        trusted-users = ["root" "@wheel"];
        warn-dirty = false;

        #flake-registry = "";
        #nix-path = config.nix.nixPath;
      };
      registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
      #nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") inputs;
    };

    programs.nix-ld.enable = true;

    programs.nix-index-database.comma.enable = true;

    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 7";
      clean.dates = "daily";
      flake = "/home/${config.user.name}/nix-config";
    };
  };
}
