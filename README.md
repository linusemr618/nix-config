# nix-config
My personal NixOS configuration

## Features

- **Secrets Management**: WiFi passwords and other secrets are securely stored using [sops-nix](https://github.com/Mic92/sops-nix)
- **Home Manager**: User environment management with home-manager
- **Modular Configuration**: Organized into reusable modules

## Setup

### Managing Secrets

This configuration uses SOPS for managing sensitive data like WiFi passwords. See [docs/SOPS-SETUP.md](docs/SOPS-SETUP.md) for detailed instructions on:
- Generating age encryption keys
- Adding and editing WiFi passwords
- Deploying secrets to your system

### Building the Configuration

```bash
# Build and switch to the new configuration
sudo nixos-rebuild switch --flake .#nix-e15411

# Or for home-manager
home-manager switch --flake .#linus@nix-e15411
```

