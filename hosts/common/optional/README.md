# Optional Features

This directory contains optional configuration modules that can be selectively imported by hosts.

## Usage

Import these modules in your host configuration when you need the functionality:

```nix
{
  imports = [
    ../../common/optional/development.nix
    ../../common/optional/gaming.nix
  ];
}
```

## Available Modules

- `development.nix` - Development tools and environments
- `gaming.nix` - Gaming support (Steam, Lutris, etc.)
- `virtualization.nix` - QEMU/KVM and container support
- `media.nix` - Media production tools

## Creating New Optional Modules

1. Create a new `.nix` file in this directory
2. Add relevant configuration
3. Document it in this README
4. Import it in hosts that need it
