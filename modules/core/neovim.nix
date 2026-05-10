{
  flake.homeModules.core = {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
