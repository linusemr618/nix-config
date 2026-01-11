{
  config,
  lib,
  inputs,
  ...
}: let
  cfg = config.networking.wireless.sops;
in {
  # Import sops-nix module
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  options.networking.wireless.sops = {
    enable = lib.mkEnableOption "SOPS-encrypted WiFi passwords";
    
    secretsFile = lib.mkOption {
      type = lib.types.path;
      default = ../../../secrets/wifi.yaml;
      description = "Path to the SOPS-encrypted WiFi secrets file";
    };

    networks = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      example = ["home_network" "work_network"];
      description = ''
        List of WiFi network names (as defined in the secrets file under wifi_networks).
        Secrets will be created for each network at /run/secrets/wifi-<network-name>
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    # Configure SOPS
    sops = {
      defaultSopsFile = cfg.secretsFile;
      
      # Age key configuration
      age = {
        # The age key file should be present on the system
        # Generate with: nix-shell -p age --run "age-keygen -o /var/lib/sops-nix/key.txt"
        keyFile = "/var/lib/sops-nix/key.txt";
        # For testing/development, you can also use:
        # keyFile = "/home/linus/.config/sops/age/keys.txt";
        
        # Generate the key file if it doesn't exist (for automated deployment)
        generateKey = true;
      };
      
      # Define secrets for WiFi networks
      # These will be available as files in /run/secrets/
      secrets = lib.mkMerge [
        # Create a secret for each network defined in the networks option
        (lib.listToAttrs (map (network: {
          name = "wifi-${network}";
          value = {
            sopsFile = cfg.secretsFile;
            key = "wifi_networks/${network}";
          };
        }) cfg.networks))
      ];
    };

    # Note: WiFi configuration with NetworkManager
    # NetworkManager stores WiFi passwords in /etc/NetworkManager/system-connections/
    # To use SOPS secrets with NetworkManager, you'll need to either:
    # 1. Use a systemd service to copy the decrypted passwords to the right location
    # 2. Use wpa_supplicant instead of NetworkManager
    # 3. Manually configure networks using nmcli with the decrypted secrets
    
    # For now, we'll set up the secrets infrastructure and provide an example
    # systemd service that could be used to configure WiFi networks
    systemd.services.configure-wifi-from-sops = {
      description = "Configure WiFi networks from SOPS secrets";
      wantedBy = ["multi-user.target"];
      after = ["network-pre.target"];
      before = ["network.target"];
      
      # This is a placeholder service
      # In practice, you would need to read the secrets and configure NetworkManager
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
      
      # Example script (not functional without actual secrets defined)
      script = ''
        # echo "WiFi secrets are available in /run/secrets/"
        # Example: nmcli connection add type wifi con-name "MyNetwork" \
        #   ifname wlan0 ssid "MyNetwork" wifi-sec.key-mgmt wpa-psk \
        #   wifi-sec.psk "$(cat /run/secrets/wifi-my-network)"
        true
      '';
    };
  };
}
