# Audio configuration using PipeWire
{
  # Disable PulseAudio (replaced by PipeWire)
  services.pulseaudio.enable = false;
  
  # Enable RealtimeKit for better audio performance
  security.rtkit.enable = true;
  
  # Enable PipeWire with ALSA and PulseAudio compatibility
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true; # For 32-bit applications
    pulse.enable = true;       # PulseAudio compatibility layer
    # jack.enable = true;      # Uncomment for JACK support
  };
}
