{ pkgs, ... }: {
  fonts = {
    # Enable a basic set of fonts for better compatibility
    enableDefaultPackages = true;
    
    packages = with pkgs; [
      # Nerd Fonts for terminal icons
      (nerdfonts.override { 
        fonts = [ 
          "FiraCode" 
          "JetBrainsMono" 
          "Meslo"
          "UbuntuMono"
        ]; 
      })
      
      # General fonts
      liberation_ttf
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      
      # Microsoft fonts (for compatibility)
      corefonts
      vistafonts
      
      # Monospace fonts
      fira-code
      jetbrains-mono
      source-code-pro
      
      # Sans-serif fonts
      ubuntu_font_family
      
      # Symbols
      font-awesome
      material-design-icons
    ];
    
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Liberation Serif" "Noto Serif" ];
        sansSerif = [ "Ubuntu" "Liberation Sans" "Noto Sans" ];
        monospace = [ "FiraCode Nerd Font" "JetBrainsMono Nerd Font" ];
        emoji = [ "Noto Color Emoji" ];
      };
      
      # Better font rendering
      antialias = true;
      hinting = {
        enable = true;
        style = "slight";
      };
      subpixel = {
        rgba = "rgb";
        lcdfilter = "default";
      };
    };
  };
}
