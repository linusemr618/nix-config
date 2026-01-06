# TODO & Future Improvements

This document tracks planned features, improvements, and ideas for the NixOS configuration.

## 🎯 High Priority

- [ ] Add hardware-specific optimizations for ThinkPad E15
  - [ ] TLP for better battery management
  - [ ] Fingerprint reader support
  - [ ] Better thermal management
- [ ] Improve security hardening
  - [ ] Enable firewall with sensible defaults
  - [ ] Configure fail2ban for SSH
  - [ ] Set up automatic security updates
- [ ] Add backup solution
  - [ ] Configure restic or borgbackup
  - [ ] Automated backup scripts
  - [ ] Cloud storage integration

## 🔧 System Configuration

- [ ] Create optional feature modules
  - [ ] Development environments (programming languages)
  - [ ] Gaming setup (Steam, Lutris, etc.)
  - [ ] Virtualization (QEMU/KVM, libvirt)
  - [ ] Docker/Podman containers
  - [ ] Media production (video/audio editing)
- [ ] Add more hosts
  - [ ] Server configuration template
  - [ ] Minimal headless setup
  - [ ] Virtual machine configuration
- [ ] Improve boot configuration
  - [ ] Consider silent boot
  - [ ] Plymouth splash screen
  - [ ] Faster boot times

## 🏠 Home Manager

- [ ] Expand home-manager configuration
  - [ ] Shell setup (zsh/fish with plugins)
  - [ ] Terminal emulator configuration (kitty/alacritty)
  - [ ] Development tools setup
  - [ ] Custom themes and appearance
- [ ] Configure development environments
  - [ ] Neovim/Editor configuration
  - [ ] Language servers and tools
  - [ ] Git aliases and hooks
  - [ ] SSH configuration
- [ ] Desktop environment tweaks
  - [ ] GNOME extensions and settings
  - [ ] GTK themes
  - [ ] Custom keybindings

## 📦 Packages & Software

- [ ] Document custom package management workflow
- [ ] Create custom packages in `pkgs/` directory
  - [ ] Any software not in nixpkgs
  - [ ] Modified versions of existing packages
- [ ] Set up development shells
  - [ ] Per-project flake templates
  - [ ] Language-specific environments
  - [ ] CI/CD integration examples

## 🔐 Security & Privacy

- [ ] VPN integration (WireGuard/OpenVPN)
- [ ] Encrypted DNS (DoH/DoT)
- [ ] Privacy-focused browser configurations
- [ ] AppArmor or SELinux profiles
- [ ] Secure boot setup

## 🌐 Networking

- [ ] Configure networking profiles (home, work, public)
- [ ] Network shares (NFS/Samba)
- [ ] mDNS/Avahi for local network discovery
- [ ] AdBlocking (Pi-hole or AdGuard Home)

## 🎨 User Experience

- [ ] Add installation script/guide
- [ ] Create configuration generator for new users
- [ ] Better error messages and validation
- [ ] Automated testing of configurations
- [ ] Documentation for each module

## 🚀 Performance

- [ ] Profile boot time and optimize
- [ ] Evaluate and optimize garbage collection
- [ ] Consider using tmpfs for /tmp
- [ ] Optimize Nix store and compression

## 📚 Documentation

- [ ] Add module-level README files
- [ ] Document all custom options
- [ ] Create troubleshooting guide
- [ ] Add examples for common tasks
- [ ] Video walkthrough of the setup

## 🔄 Maintenance

- [ ] Set up automatic flake updates (via CI/CD)
- [ ] Regular dependency audits
- [ ] Backup and disaster recovery documentation
- [ ] Migration guide for major NixOS version upgrades

## 💡 Ideas & Experiments

- [ ] Explore NixOS declarative secrets management
  - [ ] agenix
  - [ ] sops-nix
  - [ ] git-crypt
- [ ] Consider multi-user home-manager setups
- [ ] Experiment with NixOS containers
- [ ] Try alternative desktop environments (Hyprland, i3, etc.)
- [ ] Cross-compilation setup for other architectures
- [ ] Reproducible development environments for teams
- [ ] Infrastructure as Code (NixOps, deploy-rs, colmena)

## 🐛 Known Issues

- [ ] Document any current workarounds or hacks
- [ ] Track upstream issues affecting this configuration

## 🎓 Learning Resources

- [ ] Create list of helpful NixOS resources
- [ ] Add links to relevant documentation
- [ ] Maintain list of useful Nix flakes and modules

---

**Note**: This is a living document. Feel free to add, remove, or reprioritize items as needs change.
