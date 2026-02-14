{ pkgs, ... }: {
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
      
      # Wayland support
      "--ozone-platform-hint=auto"
      "--enable-features=WaylandWindowDecorations"
    ];
  };
}
