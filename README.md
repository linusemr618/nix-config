# nix-config
My personal NixOS configuration

## Features

### Stable System with Unstable Home-Manager Packages

This configuration uses a hybrid approach where:
- The system (NixOS) uses the **stable** channel (nixpkgs 25.11)
- Home-manager has access to both **stable** (`pkgs`) and **unstable** (`pkgs-unstable`) packages

This allows you to:
- Keep the system stable and reliable
- Use cutting-edge packages in your user environment when needed
- Choose on a per-package basis which channel to use

#### Usage Example

In your home-manager configuration files (e.g., `home/linus/features/cli/default.nix`):

```nix
{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.packages = with pkgs; [
    # Stable packages
    git
    vim
  ] ++ (with pkgs-unstable; [
    # Unstable packages for bleeding-edge features
    neovim
    ripgrep
  ]);
}
```

## To-Dos:
- [ ] sops-nix
- [ ] devShell
- [ ] dotfiles
  - [ ] Brave
- [ ] dconf
- [ ] impermanence
- [ ] disko
