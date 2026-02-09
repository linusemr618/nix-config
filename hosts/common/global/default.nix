{
  inputs,
  pkgs, 
  ...
}: {
  imports = [
    ./audio.nix
    ./gnome.nix
    ./home-manager.nix
    ./kernel.nix
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./nix-ld.nix
    ./openssh.nix
    ./printing.nix
    ./scsi.nix
    ./systemd-boot.nix
    ./virtualisation.nix
  ]
  ++ (builtins.attrValues inputs.self.nixosModules);

  environment.systemPackages = with pkgs; [
    gparted-full
  ];
}
