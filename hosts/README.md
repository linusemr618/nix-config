# Host Configurations

Host-specific NixOS configurations.

## Structure

```
hosts/
├── common/          # Shared configurations
│   ├── global/      # Always-imported global settings
│   ├── optional/    # Opt-in feature modules
│   └── users/       # User definitions with home-manager
└── <hostname>/      # Per-host configurations
    ├── default.nix  # Host entry point
    └── hardware-configuration.nix
```

## Global vs Optional

- **global/**: Core system settings applied to all hosts (audio, boot, locale, etc.)
- **optional/**: Feature modules imported only when needed (gaming, development, etc.)

## Adding a New Host

1. Generate hardware config:
   ```bash
   nixos-generate-config --show-hardware-config > hosts/new-host/hardware-configuration.nix
   ```

2. Create `hosts/new-host/default.nix`:
   ```nix
   {
     imports = [
       ./hardware-configuration.nix
       ../common/global
       ../common/users/yourusername
       # Add optional features as needed:
       # ../common/optional/gaming.nix
     ];
     
     networking.hostName = "new-host";
     system.stateVersion = "25.11";
   }
   ```

3. Add to `flake.nix`:
   ```nix
   nixosConfigurations.new-host = nixpkgs.lib.nixosSystem {
     specialArgs = {inherit inputs;};
     modules = [./hosts/new-host];
   };
   ```

## Host-Specific Overrides

Place host-specific settings directly in the host's `default.nix` or create additional module files within the host directory.
