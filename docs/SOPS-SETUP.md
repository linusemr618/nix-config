# SOPS Setup for WiFi Passwords

This document explains how to set up and use SOPS (Secrets OPerationS) to securely store WiFi passwords in your NixOS configuration.

## Prerequisites

- NixOS system with this configuration applied
- `sops` and `age` available (included in this flake)

## Initial Setup

### 1. Generate Age Keys

Age is the encryption tool used by SOPS. You need to generate a key pair:

```bash
# Create the directory for age keys
mkdir -p ~/.config/sops/age

# Generate a new age key
nix-shell -p age --run "age-keygen -o ~/.config/sops/age/keys.txt"
```

This will output something like:
```
# created: 2024-01-11T20:00:00Z
# public key: age1xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
AGE-SECRET-KEY-1XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

**Important**: Save the public key (the line starting with `age1...`), you'll need it in the next step.

### 2. Configure SOPS

Edit the `.sops.yaml` file in the repository root and add your age public key:

```yaml
keys:
  &host_e15411 age1xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

creation_rules:
  - path_regex: secrets/wifi\.yaml$
    age: 
      - *host_e15411
```

Replace the `age1...` with your actual public key from step 1.

### 3. Deploy the Age Key to Your System

The configuration expects the age private key at `/var/lib/sops-nix/key.txt`. Copy your key there:

```bash
sudo mkdir -p /var/lib/sops-nix
sudo cp ~/.config/sops/age/keys.txt /var/lib/sops-nix/key.txt
sudo chmod 600 /var/lib/sops-nix/key.txt
```

Alternatively, you can configure the path in `hosts/common/global/wifi-sops.nix` to use your home directory.

## Managing WiFi Passwords

### Adding WiFi Passwords

1. Edit the secrets file (it will be encrypted automatically):

```bash
nix run nixpkgs#sops -- secrets/wifi.yaml
```

2. Add your WiFi network passwords in YAML format:

```yaml
wifi_networks:
  home_network: "your-actual-wifi-password"
  work_network: "another-wifi-password"
  cafe_wifi: "yet-another-password"
```

3. Save and exit. SOPS will encrypt the file automatically.

### Viewing Encrypted Secrets

To view the decrypted contents:

```bash
nix run nixpkgs#sops -- -d secrets/wifi.yaml
```

### Editing Existing Secrets

```bash
nix run nixpkgs#sops -- secrets/wifi.yaml
```

## Using WiFi Passwords in Your System

### Option 1: Manual Configuration with NetworkManager

After the system has booted with the SOPS configuration, your secrets will be available in `/run/secrets/`. You can use them with `nmcli`:

```bash
# List available secrets
ls /run/secrets/

# Connect to a WiFi network using a secret
sudo nmcli connection add type wifi con-name "MyHomeNetwork" \
  ifname wlan0 ssid "MyHomeNetwork" \
  wifi-sec.key-mgmt wpa-psk \
  wifi-sec.psk "$(sudo cat /run/secrets/wifi-home-network)"
```

### Option 2: Automated Configuration

You can create specific secrets in the `wifi-sops.nix` module and use a systemd service to automatically configure WiFi networks. See the comments in `hosts/common/global/wifi-sops.nix` for examples.

### Option 3: wpa_supplicant

For a more declarative approach, you can switch from NetworkManager to wpa_supplicant and reference the secrets directly in your NixOS configuration.

## Security Best Practices

1. **Never commit unencrypted secrets** - Always encrypt with SOPS before committing
2. **Keep your age private key secure** - It's stored in `/var/lib/sops-nix/key.txt`
3. **Use different keys for different machines** - Each host should have its own age key
4. **Backup your age keys** - Store them securely offline
5. **Add secrets/\*.yaml to .gitignore if needed** - Only commit encrypted versions

## Troubleshooting

### "Failed to get the data key"

This means SOPS cannot decrypt the file. Ensure:
- Your age key is correctly placed at `/var/lib/sops-nix/key.txt`
- The public key in `.sops.yaml` matches your private key
- The secrets file was encrypted with the correct key

### "no such file or directory: /run/secrets/..."

The secrets haven't been decrypted yet. This happens if:
- The SOPS module isn't enabled
- The system hasn't been rebuilt with the new configuration
- The age key is missing or incorrect

Rebuild your system:
```bash
sudo nixos-rebuild switch --flake .#nix-e15411
```

## Additional Resources

- [SOPS Documentation](https://github.com/mozilla/sops)
- [sops-nix Documentation](https://github.com/Mic92/sops-nix)
- [Age Encryption](https://github.com/FiloSottile/age)
