# nix-config

My personal NixOS configuration using Nix Flakes and home-manager.

## 📁 Structure

```
.
├── flake.nix           # Flake configuration with system outputs
├── home/               # Home-manager configurations
│   └── linus/          # User-specific home configuration
├── hosts/              # Host-specific configurations
│   ├── common/         # Shared configurations across hosts
│   │   ├── global/     # Global system settings (audio, boot, etc.)
│   │   └── users/      # User configurations
│   └── e15411/         # Host-specific config (e.g., nix-e15411)
├── modules/            # Reusable NixOS and home-manager modules
│   ├── nixos/          # Custom NixOS modules
│   └── home-manager/   # Custom home-manager modules
├── overlays/           # Nixpkgs overlays
└── pkgs/               # Custom package definitions
```

## 🚀 Quick Start

### Initial Installation

1. Boot from NixOS installer
2. Clone this repository:
   ```bash
   git clone https://github.com/linusemr618/nix-config
   cd nix-config
   ```
3. Install NixOS:
   ```bash
   sudo nixos-install --flake .#nix-e15411
   ```

### Updating the System

```bash
# Update flake inputs
nix flake update

# Rebuild and switch
sudo nixos-rebuild switch --flake .#nix-e15411
```

### Formatting Code

```bash
nix fmt
```

## 🖥️ Hosts

- **nix-e15411**: Main laptop configuration (ThinkPad E15)
  - Desktop: GNOME
  - Audio: PipeWire
  - Boot: systemd-boot

## 👤 Users

- **linus**: Primary user with home-manager integration

## ✨ Features

- **Flakes**: Modern Nix configuration with reproducible builds
- **Home-manager**: Declarative user environment configuration
- **Modular Structure**: Easy to add new hosts and users
- **Overlays**: Support for custom and unstable packages

## 📝 Adding a New Host

1. Create a new directory under `hosts/`:
   ```bash
   mkdir -p hosts/new-hostname
   ```
2. Add `default.nix` and `hardware-configuration.nix`
3. Import common configurations as needed
4. Add the new host to `flake.nix`:
   ```nix
   nixosConfigurations.new-hostname = nixpkgs.lib.nixosSystem {
     specialArgs = {inherit inputs;};
     modules = [./hosts/new-hostname];
   };
   ```

## 🛠️ Development

See [TODO.md](TODO.md) for planned improvements and feature ideas.

## 📄 License

This repository is licensed under the GPL-3.0 License - see the [LICENSE](LICENSE) file for details.
