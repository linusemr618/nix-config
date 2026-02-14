{
  inputs,
  pkgs, 
  ...
}: {
  imports = [
    ./audio.nix
    ./environment.nix
    ./fish.nix
    ./fonts.nix
    ./gnome.nix
    ./home-manager.nix
    ./kernel.nix
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./nix-ld.nix
    ./openssh.nix
    ./performance.nix
    ./printing.nix
    ./scsi.nix
    ./security.nix
    ./systemd-boot.nix
    ./virtualisation.nix
    ./zram.nix
  ]
  ++ (builtins.attrValues inputs.self.nixosModules);

  # Essential system packages
  environment.systemPackages = with pkgs; [
    gparted  # Partition editor (full version with all plugins)
    vim      # Always have an editor
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
