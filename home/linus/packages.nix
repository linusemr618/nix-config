{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    brave
  ];
  programs = {
    #neovim.enable = true;
    home-manager.enable = true;
    git = {
      enable = true;
      settings = {
        user = {
          name = "Linus Emmerich";
          email = "emmerichlinus@gmail.com";
        };
        init.defaultBranch = "main";
      };
    };
  };
}
