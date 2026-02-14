# nix-config

My opinionated NixOS configuration with a focus on efficiency, developer experience, and modern tooling.

## Features

- **Flakes-based configuration** - Pure, reproducible system configuration
- **Home Manager integration** - Declarative user environment management
- **Modern CLI tools** - bat, eza, ripgrep, fd, fzf, and more
- **Fish shell** - Intelligent, user-friendly shell with custom functions
- **Neovim** - Fully configured with LSP, Treesitter, and plugins
- **GNOME desktop** - Customized with extensions and optimized settings
- **Performance optimizations** - zram, systemd in initrd, automatic garbage collection
- **Developer tools** - VSCode, PyCharm, devenv, direnv

## Structure

```
.
├── flake.nix           # Flake configuration with inputs and outputs
├── hosts/              # Host-specific configurations
│   ├── common/         # Shared host configurations
│   │   ├── global/     # System-wide settings
│   │   └── users/      # User configurations
│   └── e15411-nixos/   # Specific host config
├── home/               # Home Manager configurations
│   └── linus/          # User-specific settings
│       ├── features/   # Modular feature configurations
│       │   ├── cli/    # Command-line tools and configs
│       │   ├── desktop/# Desktop environment settings
│       │   ├── dev/    # Development tools
│       │   └── ...
│       └── global/     # Global home settings
├── lib/                # Custom library functions
├── modules/            # Reusable NixOS and Home Manager modules
├── overlays/           # Package overlays
└── pkgs/              # Custom package definitions
```

## Quick Start

### Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/linusemr618/nix-config
   cd nix-config
   ```

2. Build and activate the configuration:
   ```bash
   sudo nixos-rebuild switch --flake .#e15411-nixos
   ```

### Daily Usage

The configuration includes helpful aliases:

```bash
# System management
nr          # Rebuild and switch NixOS configuration
nrt         # Test NixOS configuration without switching
hm          # Rebuild and switch Home Manager configuration
update      # Update both NixOS and Home Manager
cleanup     # Run garbage collection

# Nix flake operations
nfu         # Update flake inputs
nfc         # Check flake validity
nfmt        # Format all Nix files with alejandra

# Modern CLI replacements
cat → bat   # Better cat with syntax highlighting
ls → eza    # Better ls with icons and git integration
grep → rg   # Faster grep (ripgrep)
find → fd   # Faster find
top → btop  # Better process viewer
```

### Development

Enter the development shell:
```bash
nix develop
```

This provides tools for working with the configuration:
- `alejandra` - Nix code formatter
- `nil` - Nix language server
- `nix-tree` - Inspect dependency trees

## Customization

### Adding a new host

1. Create a new directory in `hosts/`:
   ```bash
   mkdir -p hosts/your-hostname
   ```

2. Add a `default.nix` and `hardware-configuration.nix`

3. Update `flake.nix` to include the new host:
   ```nix
   nixosConfigurations.your-hostname = lib.nixosSystem {
     specialArgs = { inherit inputs myLib; };
     modules = [ ./hosts/your-hostname ];
   };
   ```

### Adding new features

Create feature modules in `home/linus/features/` and import them in the appropriate configuration.

## Philosophy

This configuration follows these principles:

1. **Declarative everything** - All system and user configurations are declared in Nix
2. **Opinionated defaults** - Sensible defaults that work well together
3. **Modern tooling** - Prefer modern alternatives when they provide value
4. **Performance** - Optimize for fast boot times and efficient resource usage
5. **Developer experience** - Make common tasks easy and enjoyable

## To-Do

- [ ] sops-nix for secrets management
- [ ] hibernation support
- [ ] impermanence for stateless system
- [ ] disko for declarative disk management
- [ ] More automated tests
- [ ] Additional host configurations

## Acknowledgments

Inspired by various NixOS configurations in the community, particularly:
- [Misterio77's nix-config](https://github.com/Misterio77/nix-config)
- [hlissner's dotfiles](https://github.com/hlissner/dotfiles)
