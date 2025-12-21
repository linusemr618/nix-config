# Hyprland Setup

This NixOS configuration includes a complete Hyprland setup with all essential tools and utilities for a modern Wayland desktop experience.

## Features

### Window Manager
- **Hyprland**: Modern Wayland compositor with beautiful animations and tiling capabilities
- **XWayland**: Support for running X11 applications

### System Components
- **greetd + tuigreet**: Minimal and elegant display manager
- **PipeWire**: Modern audio server with ALSA, PulseAudio, and JACK support
- **polkit-gnome**: Authentication agent for privilege escalation
- **XDG Desktop Portal**: For screen sharing, file pickers, and other desktop integrations

### User Interface
- **Waybar**: Highly customizable status bar with workspace, system, and tray information
- **Wofi**: Application launcher with search functionality
- **Dunst**: Lightweight notification daemon
- **Hyprpaper**: Wallpaper daemon for Hyprland

### Applications
- **Kitty**: GPU-accelerated terminal emulator with Catppuccin Mocha theme
- **Thunar**: Lightweight file manager with volume management
- **imv**: Image viewer optimized for Wayland
- **Zathura**: Minimal PDF viewer
- **mpv**: Versatile media player

### Utilities
- **grim + slurp**: Screenshot tools for Wayland
- **wf-recorder**: Screen recording for Wayland
- **wl-clipboard**: Clipboard utilities for Wayland
- **brightnessctl**: Backlight control
- **playerctl**: Media player control
- **pavucontrol**: PulseAudio volume control GUI

### Theming
- **GTK**: Adwaita-dark theme
- **Qt**: qt5ct/qt6ct for theme configuration
- **Icons**: Adwaita icon theme
- **Fonts**: JetBrainsMono Nerd Font
- **Colors**: Catppuccin Mocha color scheme

## Key Bindings

### General
- `SUPER + Return`: Open terminal (Kitty)
- `SUPER + Q`: Close active window
- `SUPER + M`: Exit Hyprland
- `SUPER + E`: Open file manager (Thunar)
- `SUPER + R`: Open application launcher (Wofi)
- `SUPER + V`: Toggle floating mode
- `SUPER + F`: Toggle fullscreen
- `SUPER + P`: Toggle pseudo-tiling
- `SUPER + J`: Toggle split orientation

### Window Navigation
- `SUPER + Arrow Keys` or `SUPER + hjkl`: Move focus
- `SUPER + SHIFT + Arrow Keys` or `SUPER + SHIFT + hjkl`: Move windows
- `SUPER + CTRL + Arrow Keys` or `SUPER + CTRL + hjkl`: Resize windows

### Workspaces
- `SUPER + 1-9/0`: Switch to workspace 1-10
- `SUPER + SHIFT + 1-9/0`: Move window to workspace 1-10
- `SUPER + S`: Toggle scratchpad
- `SUPER + SHIFT + S`: Move window to scratchpad
- `SUPER + Mouse Wheel`: Cycle through workspaces

### Screenshots
- `Print`: Screenshot region to clipboard
- `SUPER + Print`: Screenshot region to file (~/Pictures/)

### Mouse Bindings
- `SUPER + Left Click`: Move window
- `SUPER + Right Click`: Resize window

### Media Keys
- `XF86AudioRaiseVolume`: Increase volume
- `XF86AudioLowerVolume`: Decrease volume
- `XF86AudioMute`: Toggle mute
- `XF86AudioPlay/Pause`: Play/pause media
- `XF86AudioNext/Prev`: Next/previous track
- `XF86MonBrightnessUp/Down`: Adjust screen brightness

## Configuration

### Enabling the Setup

The Hyprland setup is modular and can be enabled/disabled easily:

**NixOS Configuration** (`nixos/configuration.nix`):
```nix
modules.hyprland.enable = true;
```

**Home Manager Configuration** (`home-manager/home.nix`):
```nix
modules.hyprland.enable = true;
```

### Customization

You can customize the configuration by editing:
- **System**: `modules/nixos/hyprland.nix`
- **User**: `modules/home-manager/hyprland.nix`

### Wallpaper

Place your wallpaper at `~/Pictures/wallpaper.png` or modify the path in `modules/home-manager/hyprland.nix` under the `services.hyprpaper.settings` section.

### Monitor Configuration

The default monitor configuration is set to automatic. To customize, edit the `monitor` setting in `modules/home-manager/hyprland.nix`:

```nix
monitor = "DP-1,1920x1080@144,0x0,1";
```

Format: `name,resolution@refresh,position,scale`

### Startup Applications

Add applications to auto-start by modifying the `exec-once` list in `modules/home-manager/hyprland.nix`:

```nix
exec-once = [
  "waybar"
  "hyprpaper"
  "dunst"
  "your-app-here"
];
```

## Building and Installation

1. Update flake inputs:
```bash
nix flake update
```

2. Build NixOS configuration:
```bash
sudo nixos-rebuild switch --flake .#your-hostname
```

3. Build home-manager configuration:
```bash
home-manager switch --flake .#your-username@your-hostname
```

## Troubleshooting

### Display Manager Issues

If greetd doesn't start Hyprland:
```bash
# Check greetd status
systemctl status greetd

# View logs
journalctl -u greetd
```

### Graphics Issues

Ensure your graphics drivers are properly configured in `hardware-configuration.nix`. For NVIDIA:
```nix
services.xserver.videoDrivers = [ "nvidia" ];
```

### XWayland Applications

If X11 applications don't work, ensure XWayland is enabled:
```nix
programs.hyprland.xwayland.enable = true;
```

### Audio Issues

Check PipeWire status:
```bash
systemctl --user status pipewire pipewire-pulse
```

## Additional Resources

- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Waybar Documentation](https://github.com/Alexays/Waybar/wiki)
- [NixOS Wiki - Hyprland](https://nixos.wiki/wiki/Hyprland)
