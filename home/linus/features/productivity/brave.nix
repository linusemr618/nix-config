{ pkgs, ... }: {
  # Note: NixOS's home-manager doesn't have a dedicated Brave module,
  # so we use the Chromium module with Brave as the package.
  # This is the recommended approach from the home-manager documentation.
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    
    extensions = [
      { id = "ghmbeldphafepmbegfdlkpapadhbakde"; }  # Proton Pass
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }  # uBlock Origin
      { id = "nngceckbapebfimnlniiiahkandclblb"; }  # Bitwarden (backup)
    ];
    
    commandLineArgs = [
      # Performance
      "--enable-gpu-rasterization"
      "--enable-zero-copy"
      "--ignore-gpu-blocklist"
      
      # Privacy
      "--disable-features=OptimizationHints"
      
      # Wayland support (better for GNOME on Wayland)
      "--ozone-platform-hint=auto"
      "--enable-features=WaylandWindowDecorations"
    ];
  };
}
