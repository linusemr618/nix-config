# SOPS WiFi Quick Reference

This is a quick reference guide for common SOPS operations with WiFi passwords.

## Initial Setup (One-time)

```bash
# 1. Generate age key
mkdir -p ~/.config/sops/age
nix-shell -p age --run "age-keygen -o ~/.config/sops/age/keys.txt"

# 2. Note your public key (starts with age1...)
cat ~/.config/sops/age/keys.txt | grep "public key"

# 3. Add public key to .sops.yaml
# Edit .sops.yaml and replace the placeholder with your actual key

# 4. Deploy key to system
sudo mkdir -p /var/lib/sops-nix
sudo cp ~/.config/sops/age/keys.txt /var/lib/sops-nix/key.txt
sudo chmod 600 /var/lib/sops-nix/key.txt
```

## Managing WiFi Passwords

```bash
# Add/Edit WiFi passwords
nix run nixpkgs#sops -- secrets/wifi.yaml

# View encrypted secrets
nix run nixpkgs#sops -- -d secrets/wifi.yaml

# Encrypt after manual editing (only if needed)
nix run nixpkgs#sops -- -e -i secrets/wifi.yaml
```

## Configuration

In `hosts/e15411/default.nix` (or your host):

```nix
networking.wireless.sops = {
  enable = true;
  networks = ["home_network" "work_network"];  # List your network names from secrets/wifi.yaml
};
```

## Rebuild System

```bash
sudo nixos-rebuild switch --flake .#nix-e15411
```

## Using the Secrets

After rebuild, secrets are available at `/run/secrets/wifi-<network_name>` (using underscores as in your network names):

```bash
# List secrets
ls /run/secrets/

# Add WiFi connection (assuming network "home_network" in your config)
sudo nmcli connection add type wifi con-name "Home" \
  ifname wlan0 ssid "Home-SSID" \
  wifi-sec.key-mgmt wpa-psk \
  wifi-sec.psk "$(sudo cat /run/secrets/wifi-home_network)"
```

## Troubleshooting

```bash
# Check if secrets are decrypted
ls -l /run/secrets/

# Verify age key exists
ls -l /var/lib/sops-nix/key.txt

# Test decryption manually
nix run nixpkgs#sops -- -d secrets/wifi.yaml
```
