{ pkgs, ... }: {
  imports = [
    ./audio.nix
    ./boot.nix
    ./gnome.nix
    ./home-manager.nix
    ./kernel.nix
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./openssh.nix
    ./printing.nix
    ./scsi.nix
  ];

  environment.systemPackages = with pkgs; [
    
  ];
}
