# GNOME desktop environment configuration
{
  # Enable GDM display manager
  services.displayManager.gdm.enable = true;
  
  # Enable GNOME desktop
  services.desktopManager.gnome.enable = true;
  
  # Optional GNOME customizations:
  # environment.gnome.excludePackages = with pkgs; [
  #   gnome-tour        # Remove welcome tour
  #   epiphany          # Remove GNOME web browser
  #   geary             # Remove email client
  # ];
}
