{
  flake.nixosModules.core = {
    config,
    pkgs,
    ...
  }: {
    virtualisation = {
      containers.enable = true;
      podman = {
        enable = true;
        dockerCompat = true;
        dockerSocket.enable = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };
    environment.systemPackages = with pkgs; [
      podman-compose
    ];

    users.users.${config.user.name}.extraGroups = ["podman"];
  };
}
