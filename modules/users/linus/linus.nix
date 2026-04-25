{
  flake.nixosModules.linus = {
    users.users.linus = {
      isNormalUser = true;
      description = "Linus Emmerich";
      extraGroups = ["networkmanager" "wheel" "libvirtd"];
    };
  };

  flake.homeModules.linus = {
    home = {
      username = "linus";
      homeDirectory = "/home/linus";
      stateVersion = "26.05";
    };
  };
}
