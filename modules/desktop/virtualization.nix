{
  flake.nixosModules.core = {config, ...}: {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
    users.users.${config.user.name}.extraGroups = ["libvirtd"];
  };

  flake.homeModules.core = {pkgs, ...}: {
    home.packages = with pkgs; [
      gnome-boxes
    ];
  };
}
