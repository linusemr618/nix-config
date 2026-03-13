{
  inputs,
  pkgs,
  ...
}: {
  imports =
    [
      ../features/apps
      ../features/cli
      ../features/desktop/gnome

      #./nix.nix
    ]
    ++ (builtins.attrValues inputs.self.homeManagerModules);

  home = {
    username = "linus";
    homeDirectory = "/home/linus";
  };

  home.packages = with pkgs; [
  ];

  systemd.user.startServices = "sd-switch";
  home.stateVersion = "25.11";
}
