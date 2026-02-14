{
  # Enable zram for better memory management
  # This creates a compressed swap partition in RAM
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;  # Use up to 50% of RAM for zram
  };
}
