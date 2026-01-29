{
  outputs,
  pkgs, 
  ...
}: {
  imports = [
    ./audio.nix
    ./boot.nix
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
  ]
  ++ (builtins.attrValues outputs.nixosModules);

  environment.systemPackages = with pkgs; [
    
  ];
}
