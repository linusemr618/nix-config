# Linux kernel configuration
{
  pkgs,
  ...
}: {
  # Use the latest stable kernel
  # Alternative options:
  # - pkgs.linuxPackages (default stable)
  # - pkgs.linuxPackages_zen (optimized for desktop)
  # - pkgs.linuxPackages_hardened (security focused)
  # - pkgs.linuxPackages_lts (long-term support)
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
