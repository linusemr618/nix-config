{ pkgs, ... }: {
  # Enable libvirt for virtual machines
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = false;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [ pkgs.OVMFFull.fd ];
        };
      };
    };
    
    # Enable Docker for containers
    docker = {
      enable = true;
      enableOnBoot = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
    
    # Podman as an alternative to Docker
    podman = {
      enable = true;
      dockerCompat = false;  # Don't conflict with Docker
      defaultNetwork.settings.dns_enabled = true;
    };
  };
  
  # Add user to necessary groups
  users.users.linus.extraGroups = [ "libvirtd" "docker" ];
  
  # Useful virtualisation packages
  environment.systemPackages = with pkgs; [
    virt-manager
    docker-compose
  ];
}
