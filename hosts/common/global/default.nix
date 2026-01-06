# Global system settings imported by all hosts
{
  imports = [
    ./audio.nix       # PipeWire audio configuration
    ./boot.nix        # Boot loader settings
    ./gnome.nix       # GNOME desktop environment
    ./kernel.nix      # Linux kernel selection
    ./locale.nix      # Timezone and localization
    ./networking.nix  # Network configuration
    ./nix-settings.nix # Nix daemon and flake settings
    ./openssh.nix     # SSH server configuration
    ./printing.nix    # CUPS printing support
  ];
}
