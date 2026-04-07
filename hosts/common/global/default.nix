{
  inputs,
  pkgs,
  ...
}: {
  imports =
    [
      ./audio.nix
      ./firmware.nix
      ./fish.nix
      ./gnome.nix
      ./home-manager.nix
      ./kernel.nix
      ./locale.nix
      ./networking.nix
      ./nix.nix
      ./openssh.nix
      ./printing.nix
      ./systemd-boot.nix
      ./virtualisation.nix
    ]
    ++ (builtins.attrValues inputs.self.nixosModules);

  environment.systemPackages = with pkgs; [
    aircrack-ng
    gparted
  ];
}
