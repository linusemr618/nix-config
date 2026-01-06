# Contributing Guide

Thank you for considering contributing to this NixOS configuration!

## 🏗️ Development Workflow

### Making Changes

1. **Test your changes locally**:
   ```bash
   # Test without switching
   sudo nixos-rebuild test --flake .#nix-e15411
   
   # Apply changes permanently
   sudo nixos-rebuild switch --flake .#nix-e15411
   ```

2. **Format code** before committing:
   ```bash
   nix fmt
   ```

3. **Check for issues**:
   ```bash
   # Validate flake
   nix flake check
   ```

### Code Style

- Use 2 spaces for indentation in Nix files
- Follow the [Nix style guide](https://nix.dev/contributing/documentation/style-guide)
- Keep lines under 100 characters when possible
- Use meaningful variable and module names
- Add comments for complex or non-obvious configurations

### File Organization

- **Global settings** → `hosts/common/global/`
- **Optional features** → `hosts/common/optional/`
- **User configs** → `home/<username>/`
- **Custom packages** → `pkgs/`
- **Overlays** → `overlays/`

### Commit Messages

Use clear, descriptive commit messages:

```
feat: add gaming module with Steam support
fix: correct audio configuration for pipewire
docs: update README with installation steps
refactor: reorganize host configurations
```

## 🧪 Testing

### Before Committing

1. Ensure the configuration builds:
   ```bash
   nix build .#nixosConfigurations.nix-e15411.config.system.build.toplevel
   ```

2. Test in a VM (if possible):
   ```bash
   nixos-rebuild build-vm --flake .#nix-e15411
   ./result/bin/run-nix-e15411-vm
   ```

3. Check for warnings:
   ```bash
   nix flake check --show-trace
   ```

## 📝 Documentation

- Update README.md for structural changes
- Add comments in code for complex configurations
- Update TODO.md when completing or adding tasks
- Create module-level READMEs for new directories

## 🔒 Security

- Never commit secrets or passwords
- Use agenix or sops-nix for sensitive data
- Review security implications of new modules
- Keep dependencies up to date

## 🐛 Reporting Issues

If you encounter problems:

1. Check existing issues
2. Include relevant configuration snippets
3. Provide system information
4. Describe expected vs actual behavior

## 💡 Suggesting Features

Feature suggestions are welcome! Consider:

- Use cases and benefits
- Impact on existing configurations
- Implementation complexity
- Alignment with project goals

## 🙏 Attribution

When using code from other sources:

- Provide attribution in comments
- Respect original licenses
- Link to sources when helpful

---

**Questions?** Feel free to open an issue for discussion!
