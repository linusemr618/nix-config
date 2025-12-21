# nix-config

My personal NixOS configuration with Hyprland desktop environment.

## Features

- **Hyprland**: Modern Wayland compositor with beautiful animations
- **Modular Configuration**: Easy to enable/disable components
- **Home Manager**: Declarative user environment management
- **Flakes**: Modern Nix package management

## Quick Start

See [HYPRLAND.md](HYPRLAND.md) for detailed Hyprland setup documentation.

### Building

```bash
# NixOS
sudo nixos-rebuild switch --flake .#your-hostname

# Home Manager
home-manager switch --flake .#your-username@your-hostname
```
