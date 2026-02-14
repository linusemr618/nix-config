{
  inputs,
  pkgs, 
  ...
}: {
  imports = [
    ./audio.nix
    ./environment.nix
    ./fish.nix
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
    ./zram.nix
  ]
  ++ (builtins.attrValues inputs.self.nixosModules);

  # Essential system packages
  environment.systemPackages = with pkgs; [
    gparted
    vim  # Always have an editor
    wget
    curl
  ];
  
  # Enable documentation
  documentation = {
    enable = true;
    man.enable = true;
    dev.enable = true;
  };
}
