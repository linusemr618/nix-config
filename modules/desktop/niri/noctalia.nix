{inputs, ...}: {
  flake.nixosModules.desktopNiri = {
    imports = [inputs.noctalia.homeModules.noctalia];
    programs.noctalia-shell = {
      enable = true;
      settings = {
        theme = "dark";
      };
    };
  };
}
