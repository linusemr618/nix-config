# Quick Reference Guide

A quick reference for common tasks and commands in this NixOS configuration.

## 🚀 Common Commands

### System Management

```bash
# Rebuild and switch to new configuration
sudo nixos-rebuild switch --flake .#nix-e15411

# Test configuration without switching (reverts on reboot)
sudo nixos-rebuild test --flake .#nix-e15411

# Build configuration without activating
sudo nixos-rebuild build --flake .#nix-e15411

# Build and test in VM
nixos-rebuild build-vm --flake .#nix-e15411
./result/bin/run-nix-e15411-vm
```

### Flake Management

```bash
# Update all flake inputs
nix flake update

# Update specific input
nix flake lock --update-input nixpkgs

# Show flake metadata
nix flake metadata

# Check flake for errors
nix flake check
```

### Package Management

```bash
# Search for a package
nix search nixpkgs <package-name>

# Install package temporarily
nix shell nixpkgs#<package-name>

# Run package without installing
nix run nixpkgs#<package-name>

# Build custom package
nix build .#<package-name>
```

### Garbage Collection

```bash
# List generations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Delete old generations (older than 30 days)
sudo nix-collect-garbage --delete-older-than 30d

# Delete all old generations except current
sudo nix-collect-garbage -d

# Optimize nix store (deduplicate)
nix-store --optimise
```

### Code Formatting

```bash
# Format all nix files
nix fmt

# Format specific file
nix fmt path/to/file.nix
```

## 📁 File Locations

```
Configuration:    /etc/nixos/ (symlinked from this repo)
System profile:   /nix/var/nix/profiles/system
User profile:     ~/.nix-profile
Nix store:        /nix/store
```

## 🔧 Configuration Structure

### Adding Packages

**System-wide packages** (all users):
- Add to `hosts/common/optional/<feature>.nix`
- Or create new optional module

**User-specific packages**:
- Add to `home/<username>/packages.nix`

### Enabling Optional Features

Edit `hosts/<hostname>/default.nix`:
```nix
imports = [
  # ... existing imports ...
  ../common/optional/development.nix
  ../common/optional/gaming.nix
];
```

### Adding a New Host

1. Create directory: `hosts/new-hostname/`
2. Add `default.nix` and `hardware-configuration.nix`
3. Update `flake.nix` to include new host
4. Build with: `sudo nixos-rebuild switch --flake .#new-hostname`

## 🐛 Troubleshooting

### Build Fails

```bash
# Show detailed error trace
nixos-rebuild switch --flake .#nix-e15411 --show-trace

# Check flake syntax
nix flake check --show-trace
```

### Rollback Changes

```bash
# List generations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Rollback to previous generation
sudo nixos-rebuild switch --rollback

# Switch to specific generation
sudo nix-env --profile /nix/var/nix/profiles/system --switch-generation <number>
sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch
```

### Check System Info

```bash
# Current NixOS version
nixos-version

# System configuration
nixos-option system

# Check what changed
nix store diff-closures /nix/var/nix/profiles/system-{old,new}-link
```

## 🔑 Useful Environment Variables

```bash
# Use unstable package in shell
nix shell nixpkgs#hello --override-input nixpkgs nixpkgs-unstable

# Increase verbosity
export NIX_DEBUG=1
```

## 📚 Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Nix Package Search](https://search.nixos.org/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Nix Pills](https://nixos.org/guides/nix-pills/)
- [NixOS Wiki](https://nixos.wiki/)

## ⚡ Pro Tips

1. **Test before switching**: Use `test` instead of `switch` to try configurations
2. **Keep generations**: Don't delete all old generations immediately in case you need to rollback
3. **Use overlays**: For package modifications, use overlays instead of forking
4. **Pin versions**: Lock flake inputs for reproducibility
5. **Document changes**: Add comments explaining non-obvious configurations
