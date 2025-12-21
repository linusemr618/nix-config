{ inputs, lib, config, pkgs, ... }:

{
  options.modules.hyprland.enable = lib.mkEnableOption "Hyprland user configuration";

  config = lib.mkIf config.modules.hyprland.enable {
    # Enable Hyprland
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland.enable = true;
      
      settings = {
        # Monitor configuration
        monitor = ",preferred,auto,1";

        # Execute on launch
        exec-once = [
          "waybar"
          "hyprpaper"
          "dunst"
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        ];

        # Environment variables
        env = [
          "XCURSOR_SIZE,24"
          "QT_QPA_PLATFORMTHEME,qt5ct"
        ];

        # Input configuration
        input = {
          kb_layout = "us";
          follow_mouse = 1;
          touchpad = {
            natural_scroll = true;
          };
          sensitivity = 0;
        };

        # General window settings
        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          layout = "dwindle";
          allow_tearing = false;
        };

        # Decoration settings
        decoration = {
          rounding = 8;
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
          };
          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "rgba(1a1a1aee)";
        };

        # Animation settings
        animations = {
          enabled = true;
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        # Layout settings
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        master = {
          new_is_master = true;
        };

        # Gestures
        gestures = {
          workspace_swipe = true;
        };

        # Misc settings
        misc = {
          force_default_wallpaper = 0;
          disable_hyprland_logo = true;
        };

        # Key bindings
        "$mod" = "SUPER";

        bind = [
          # Application launchers
          "$mod, Return, exec, kitty"
          "$mod, Q, killactive,"
          "$mod, M, exit,"
          "$mod, E, exec, thunar"
          "$mod, V, togglefloating,"
          "$mod, R, exec, wofi --show drun"
          "$mod, P, pseudo,"
          "$mod, J, togglesplit,"
          "$mod, F, fullscreen,"

          # Move focus
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"
          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"

          # Move windows
          "$mod SHIFT, left, movewindow, l"
          "$mod SHIFT, right, movewindow, r"
          "$mod SHIFT, up, movewindow, u"
          "$mod SHIFT, down, movewindow, d"
          "$mod SHIFT, h, movewindow, l"
          "$mod SHIFT, l, movewindow, r"
          "$mod SHIFT, k, movewindow, u"
          "$mod SHIFT, j, movewindow, d"

          # Workspace switching
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 10"

          # Move windows to workspaces
          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"
          "$mod SHIFT, 0, movetoworkspace, 10"

          # Special workspace (scratchpad)
          "$mod, S, togglespecialworkspace, magic"
          "$mod SHIFT, S, movetoworkspace, special:magic"

          # Scroll through workspaces
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"

          # Screenshots
          ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"
          "$mod, Print, exec, grim -g \"$(slurp)\" ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png"
        ];

        # Mouse bindings
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        # Resize bindings
        binde = [
          "$mod CTRL, left, resizeactive, -20 0"
          "$mod CTRL, right, resizeactive, 20 0"
          "$mod CTRL, up, resizeactive, 0 -20"
          "$mod CTRL, down, resizeactive, 0 20"
          "$mod CTRL, h, resizeactive, -20 0"
          "$mod CTRL, l, resizeactive, 20 0"
          "$mod CTRL, k, resizeactive, 0 -20"
          "$mod CTRL, j, resizeactive, 0 20"
        ];

        # Media keys
        bindl = [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPause, exec, playerctl play-pause"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
          ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        ];
      };
    };

    # Waybar configuration
    programs.waybar = {
      enable = true;
      settings = [{
        layer = "top";
        position = "top";
        height = 30;
        
        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "network" "cpu" "memory" "battery" "tray" ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };

        "hyprland/window" = {
          max-length = 50;
        };

        clock = {
          format = "{:%H:%M}";
          format-alt = "{:%Y-%m-%d}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
        };

        cpu = {
          format = " {usage}%";
          tooltip = false;
        };

        memory = {
          format = " {}%";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-icons = [ "" "" "" "" "" ];
        };

        network = {
          format-wifi = " {essid}";
          format-ethernet = " {ifname}";
          format-disconnected = "⚠ Disconnected";
          tooltip-format = "{ifname}: {ipaddr}";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = " Muted";
          format-icons = {
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };

        tray = {
          spacing = 10;
        };
      }];

      style = ''
        * {
          border: none;
          border-radius: 0;
          font-family: "JetBrainsMono Nerd Font";
          font-size: 13px;
          min-height: 0;
        }

        window#waybar {
          background: rgba(30, 30, 46, 0.9);
          color: #cdd6f4;
        }

        #workspaces button {
          padding: 0 5px;
          color: #cdd6f4;
          background: transparent;
        }

        #workspaces button.active {
          background: #89b4fa;
          color: #1e1e2e;
        }

        #workspaces button:hover {
          background: #45475a;
        }

        #clock,
        #battery,
        #cpu,
        #memory,
        #network,
        #pulseaudio,
        #tray,
        #window {
          padding: 0 10px;
        }

        #battery.charging {
          color: #a6e3a1;
        }

        #battery.warning:not(.charging) {
          color: #f9e2af;
        }

        #battery.critical:not(.charging) {
          color: #f38ba8;
        }
      '';
    };

    # Terminal emulator (Kitty)
    programs.kitty = {
      enable = true;
      settings = {
        font_family = "JetBrainsMono Nerd Font";
        font_size = 11;
        background_opacity = "0.9";
        confirm_os_window_close = 0;
        enable_audio_bell = false;
        
        # Catppuccin Mocha theme
        foreground = "#CDD6F4";
        background = "#1E1E2E";
        selection_foreground = "#1E1E2E";
        selection_background = "#F5E0DC";
        
        cursor = "#F5E0DC";
        cursor_text_color = "#1E1E2E";
        
        # Black
        color0 = "#45475A";
        color8 = "#585B70";
        
        # Red
        color1 = "#F38BA8";
        color9 = "#F38BA8";
        
        # Green
        color2 = "#A6E3A1";
        color10 = "#A6E3A1";
        
        # Yellow
        color3 = "#F9E2AF";
        color11 = "#F9E2AF";
        
        # Blue
        color4 = "#89B4FA";
        color12 = "#89B4FA";
        
        # Magenta
        color5 = "#F5C2E7";
        color13 = "#F5C2E7";
        
        # Cyan
        color6 = "#94E2D5";
        color14 = "#94E2D5";
        
        # White
        color7 = "#BAC2DE";
        color15 = "#A6ADC8";
      };
    };

    # Notification daemon
    services.dunst = {
      enable = true;
      settings = {
        global = {
          width = 300;
          height = 300;
          offset = "30x50";
          origin = "top-right";
          transparency = 10;
          frame_color = "#89b4fa";
          font = "JetBrainsMono Nerd Font 10";
          corner_radius = 8;
        };

        urgency_low = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
          timeout = 5;
        };

        urgency_normal = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
          timeout = 10;
        };

        urgency_critical = {
          background = "#1e1e2e";
          foreground = "#f38ba8";
          frame_color = "#f38ba8";
          timeout = 0;
        };
      };
    };

    # Application launcher (Wofi)
    programs.wofi = {
      enable = true;
      settings = {
        width = 600;
        height = 400;
        location = "center";
        show = "drun";
        prompt = "Search...";
        filter_rate = 100;
        allow_markup = true;
        no_actions = true;
        halign = "fill";
        orientation = "vertical";
        content_halign = "fill";
        insensitive = true;
        allow_images = true;
        image_size = 40;
      };

      style = ''
        window {
          margin: 0px;
          border: 2px solid #89b4fa;
          background-color: #1e1e2e;
          border-radius: 8px;
        }

        #input {
          margin: 5px;
          border: 2px solid #45475a;
          color: #cdd6f4;
          background-color: #313244;
          border-radius: 4px;
        }

        #inner-box {
          margin: 5px;
          border: none;
          background-color: #1e1e2e;
        }

        #outer-box {
          margin: 5px;
          border: none;
          background-color: #1e1e2e;
        }

        #scroll {
          margin: 0px;
          border: none;
        }

        #text {
          margin: 5px;
          border: none;
          color: #cdd6f4;
        }

        #entry:selected {
          background-color: #45475a;
          border-radius: 4px;
        }

        #entry:selected #text {
          color: #89b4fa;
        }
      '';
    };

    # Wallpaper daemon
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        preload = [
          "~/Pictures/wallpaper.png"
        ];
        wallpaper = [
          ",~/Pictures/wallpaper.png"
        ];
      };
    };

    # Additional packages
    home.packages = with pkgs; [
      # Fonts
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

      # Utilities
      wl-clipboard
      cliphist
      wl-clip-persist
      
      # Theme and appearance
      qt5ct
      qt6ct
      lxappearance
      
      # Image viewer
      imv
      
      # PDF viewer
      zathura
      
      # Video player
      mpv
      
      # Network manager applet
      networkmanagerapplet
      
      # Bluetooth manager
      blueman
    ];

    # GTK theme
    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome.gnome-themes-extra;
      };
      iconTheme = {
        name = "Adwaita";
        package = pkgs.gnome.adwaita-icon-theme;
      };
      cursorTheme = {
        name = "Adwaita";
        package = pkgs.gnome.adwaita-icon-theme;
      };
    };

    # Qt theme
    qt = {
      enable = true;
      platformTheme = "qtct";
    };

    # XDG user directories
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
