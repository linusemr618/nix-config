{
  flake.nixosModules.core = {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
  };

  flake.homeModules.core = {pkgs, ...}: {
    home.packages = with pkgs; [
      gnome-boxes
    ];
  };
}
