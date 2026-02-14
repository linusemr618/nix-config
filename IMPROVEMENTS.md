# Configuration Improvements Summary

This document summarizes all the improvements made to make the nix-config more efficient, clever, and opinionated.

## Major Changes

### 1. Flake Architecture Improvements

**What Changed:**
- Removed `flake-utils` dependency in favor of native `lib.genAttrs`
- Added custom library functions in `lib/default.nix`
- Reorganized flake outputs for better clarity
- Updated `flake.lock` to reflect new structure

**Benefits:**
- Cleaner, more maintainable code
- Fewer dependencies
- Better reusability through library functions
- More explicit and understandable structure

### 2. Library Functions (`lib/default.nix`)

**New Utilities:**
- `mkSystem`: Helper to create NixOS configurations
- `mapModules`: Import modules from a directory
- `mapModulesAsList`: Get list of modules from directory
- `enabled`/`disabled`: Quick enable/disable helpers

**Benefits:**
- Reduce boilerplate code
- Easier to add new hosts
- Consistent patterns across config

### 3. Shell and CLI Improvements

**Fish Shell:**
- Set as default shell system-wide
- Custom abbreviations for common commands
- Useful functions (mkcd, extract, etc.)
- Tide and autopair plugins

**Modern CLI Tools:**
- `bat` instead of `cat`
- `eza` instead of `ls`
- `ripgrep` instead of `grep`
- `fd` instead of `find`
- `zoxide` instead of `cd`
- `btop` instead of `top`
- `dust`, `duf`, `procs` for better system info

**Configuration:**
- Starship prompt for beautiful terminal
- tmux with vim bindings
- Extensive shell aliases
- direnv for automatic environment loading

### 4. Neovim as Full IDE

**Features:**
- LSP support for Nix, Python, TypeScript, Bash, Lua
- Treesitter for better syntax highlighting
- File tree (nvim-tree)
- Fuzzy finding (Telescope)
- Git integration (gitsigns, fugitive)
- Auto-completion with nvim-cmp
- Beautiful color scheme (Catppuccin)
- Custom keybindings

**Benefits:**
- Full IDE experience in terminal
- Consistent across all environments
- Fast and lightweight

### 5. Git Configuration

**Improvements:**
- Better diff algorithm (histogram)
- Commit conflict style (zdiff3)
- Useful aliases (lg, last, amend, etc.)
- Git delta for better diffs
- Auto-setup remote on push
- Comprehensive gitignore patterns

### 6. VSCode Enhancement

**Features:**
- Nix IDE extension
- Python with Pylance
- GitLens for better Git integration
- Catppuccin theme
- Vim keybindings
- Format on save
- FiraCode font with ligatures

### 7. System Performance Optimizations

**Boot:**
- systemd in initrd for faster boot
- Plymouth for boot splash
- Silent boot (quiet splash)
- Boot timeout reduced to 3 seconds
- Limited boot generations to 10

**Memory:**
- zram enabled (50% of RAM)
- Swappiness set to 10 (prefer RAM)

**Nix:**
- Auto-optimize store
- Automatic garbage collection (7 days)
- builders-use-substitutes enabled
- keep-outputs and keep-derivations enabled

### 8. Security Hardening

**SSH:**
- Public key only authentication
- No root login
- Strong ciphers and key exchange
- fail2ban integration
- Reduced login attempts

**System:**
- AppArmor enabled
- Kernel hardening (sysctl)
- Firewall enabled
- dmesg restricted
- Secure networking defaults

### 9. Virtualization & Containers

**Features:**
- libvirt with QEMU/KVM
- Docker with auto-pruning
- Podman as alternative
- virt-manager GUI
- docker-compose

### 10. Fonts Configuration

**Included:**
- Nerd Fonts (FiraCode, JetBrainsMono, etc.)
- Noto fonts family
- Liberation fonts
- Microsoft fonts for compatibility
- Font Awesome and Material Design Icons

**Settings:**
- Better font rendering (antialiasing, hinting)
- Sensible defaults for serif, sans-serif, monospace

### 11. Networking Enhancements

**Features:**
- NetworkManager with OpenConnect and OpenVPN
- WiFi power saving
- Firewall enabled (no ping)
- systemd-resolved with DNSSEC
- Fallback DNS (Cloudflare, Google)

### 12. Developer Tools

**Python:**
- Common packages (requests, pytest, black, etc.)
- Poetry for dependency management
- Ruff for fast linting
- ipython for better REPL

**System:**
- devenv for dev environments
- direnv integration
- Language servers for multiple languages
- Better development shell

### 13. Documentation

**README.md:**
- Comprehensive structure documentation
- Quick start guide
- Usage examples
- Customization instructions
- Philosophy section

**shell.nix:**
- Helpful welcome message
- Common command reminders

## File Changes Summary

### New Files Created:
- `lib/default.nix` - Library functions
- `home/linus/features/cli/fish.nix` - Fish shell config
- `home/linus/features/cli/starship.nix` - Starship prompt
- `home/linus/features/cli/btop.nix` - System monitor config
- `home/linus/features/cli/tmux.nix` - Terminal multiplexer
- `home/linus/features/cli/ssh.nix` - SSH client config
- `hosts/common/global/fish.nix` - System-wide fish
- `hosts/common/global/zram.nix` - Compressed swap
- `hosts/common/global/environment.nix` - Environment variables
- `hosts/common/global/security.nix` - Security hardening
- `hosts/common/global/fonts.nix` - Font configuration

### Significantly Enhanced:
- `flake.nix` - Better structure, removed flake-utils
- `shell.nix` - More tools, helpful messages
- `README.md` - Comprehensive documentation
- `home/linus/features/cli/default.nix` - Modern tools, aliases
- `home/linus/features/cli/git.nix` - Better config, delta
- `home/linus/features/cli/neovim.nix` - Full IDE setup
- `home/linus/features/cli/python.nix` - Better dev environment
- `home/linus/features/dev/vscode.nix` - Extensions, settings
- `home/linus/features/desktop/gnome/settings.nix` - More settings
- `home/linus/features/desktop/gnome/extensions.nix` - Better config
- `home/linus/features/productivity/brave.nix` - Chromium config
- `home/linus/global/default.nix` - Session variables, packages
- `hosts/common/global/nix.nix` - Optimizations
- `hosts/common/global/kernel.nix` - systemd in initrd
- `hosts/common/global/systemd-boot.nix` - Plymouth, security
- `hosts/common/global/virtualisation.nix` - Docker, Podman
- `hosts/common/global/openssh.nix` - Security hardening
- `hosts/common/global/networking.nix` - Better defaults

## Philosophy

The revised configuration follows these principles:

1. **Opinionated Defaults** - Choose the best tool for each job
2. **Modern Tooling** - Use modern replacements when they're better
3. **Security First** - Harden system while maintaining usability
4. **Developer Experience** - Make development pleasant and productive
5. **Performance** - Optimize for speed without sacrificing features
6. **Maintainability** - Clean, well-organized, documented code

## Next Steps

To use this configuration:

1. Review the changes in this PR
2. Test the configuration: `nix flake check`
3. Build the system: `sudo nixos-rebuild switch --flake .#e15411-nixos`
4. Enjoy your improved NixOS experience!

## Feedback Welcome

This is an opinionated configuration. If you have different preferences:
- Fork and customize
- Submit PRs for genuine improvements
- Open issues for bugs or questions
