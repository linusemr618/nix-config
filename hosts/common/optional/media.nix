# Media production tools
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Video editing
    kdenlive
    # blender # 3D graphics (large package)
    
    # Audio production
    audacity
    # ardour # DAW (Digital Audio Workstation)
    
    # Image editing
    gimp
    inkscape
    krita
    
    # Media utilities
    ffmpeg
    imagemagick
    
    # Screen recording
    obs-studio
    simplescreenrecorder
  ];
  
  # Better audio latency for production
  security.rtkit.enable = true;
}
