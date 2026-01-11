{
  pkgs,
  ...
}: {
  imports = [
    ./audio.nix
    ./boot.nix
    ./gnome.nix
    ./kernel.nix
    ./locale.nix
    ./networking.nix
    ./nix-settings.nix
    ./openssh.nix
    ./printing.nix
    ./wifi-sops.nix
  ];

  environment.systemPackages = with pkgs; [
    
  ];
}
