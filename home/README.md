# Home Configurations

User-specific home-manager configurations.

## Structure

Each user has their own subdirectory containing:
- `default.nix` - Main home-manager configuration
- `packages.nix` - User-specific packages and program configurations
- Additional module files as needed

## Adding a New User

1. Create a new directory: `mkdir home/newuser`
2. Create `default.nix` with base configuration
3. Create `packages.nix` for user-specific packages
4. Import the user in the appropriate host configuration

## Best Practices

- Keep system-wide packages in host configuration
- Use home-manager for user-specific dotfiles and programs
- Split large configurations into separate module files
- Use comments to explain non-obvious configurations
