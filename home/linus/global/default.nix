{
  imports = [
    ../features/cli
    ../features/desktop
    ../features/development
    ../features/media
    ../features/productivity

    #./nix.nix
  ];

  home = {
    username = "linus";
    homeDirectory = "/home/linus";
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.11";
}
