{
  flake.nixosModules.core = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      aircrack-ng
    ];
  };

  flake.homeModules.core = {pkgs, ...}: {
    home.packages = with pkgs; [
      age
      android-tools
      devenv
      gcc
      git
      sops
      ssh-to-age
      wget

      (python3.withPackages (ps: [ps.tkinter]))
    ];
  };
}
