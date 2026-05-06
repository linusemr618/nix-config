{
  flake.nixosModules.core = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      aircrack-ng
    ];
  };

  flake.homeModules.core = {pkgs, ...}: {
    home.packages = with pkgs; [
      android-tools
      devenv
      gcc
      git
      vim
      wget

      (python3.withPackages (ps:
        with ps; [
          tkinter
        ]))
    ];
  };
}
