{pkgs, ...}: {
  imports = [
    ../common

    ./dash-folders.nix
    ./extensions.nix
    ./settings.nix
    ./theme.nix
  ];

  programs.gnome-shell.enable = true;
  dconf.enable = true;

  home.packages = with pkgs; [
    gnome-boxes
    gnome-tweaks
  ];
}
