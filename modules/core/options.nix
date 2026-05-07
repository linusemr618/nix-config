{
  flake.nixosModules.core = {lib, ...}: {
    options.user = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "linus";
      };
      description = lib.mkOption {
        type = lib.types.str;
        default = "Linus Emmerich";
      };
    };
  };

  flake.homeModules.core = {lib, ...}: {
    options.user = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "linus";
      };
      description = lib.mkOption {
        type = lib.types.str;
        default = "Linus Emmerich";
      };
    };
  };
}
