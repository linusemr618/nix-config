{ inputs, ... }: {
  nixpkgs = {
    # You can add overlays here
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };
}