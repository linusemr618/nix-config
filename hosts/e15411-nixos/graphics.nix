{pkgs, ...}: {
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # For Broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
      vpl-gpu-rt
      intel-compute-runtime
    ];
  };
  services.xserver.videoDrivers = ["modesetting"];
  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";}; # Optionally, set the environment variable
  boot.kernelParams = ["i915.enable_guc=3"];
}
