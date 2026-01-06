# Printing support via CUPS
{
  # Enable CUPS for printing
  services.printing.enable = true;
  
  # Optional: Enable printer discovery
  # services.avahi = {
  #   enable = true;
  #   nssmdns4 = true;
  #   openFirewall = true;
  # };
}
