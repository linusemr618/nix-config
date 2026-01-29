{
  outputs,
  pkgs,
  ...
}: {
  imports = [
    ../features/cli
    ../features/desktop/gnome
    ../features/dev
    ../features/media
    ../features/productivity
    ../features/utils

    #./nix.nix
  ]
  ++ (builtins.attrValues outputs.homeManagerModules);

  home = {
    username = "linus";
    homeDirectory = "/home/linus";
  };

  home.packages = with pkgs; [

  ];

  systemd.user.startServices = "sd-switch";
  home.stateVersion = "25.11";
}
