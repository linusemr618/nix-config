{
  flake.homeModules.core = {
    programs.git = {
      enable = true;
      lfs.enable = true;
      settings = {
        user = {
          name = "Linus Emmerich";
          email = "emmerichlinus@gmail.com";
        };
        init.defaultBranch = "main";
        pull.rebase = "true";
        core.autocrlf = "input";
      };
    };
  };
}
