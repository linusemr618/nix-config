{inputs, ...}: {
  flake.nixosModules.core = {lib, ...}: {
    nixpkgs.config.allowUnfree = true;
    nix = {
      channel.enable = false;
      gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 7d";
      };
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
  };
}
