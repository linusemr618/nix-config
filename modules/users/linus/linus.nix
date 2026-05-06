{
  flake.nixosModules.linus = {pkgs, ...}: {
    users.users.linus = {
      isNormalUser = true;
      description = "Linus Emmerich";
      extraGroups = ["networkmanager" "wheel" "libvirtd"];
      shell = pkgs.fish;
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
