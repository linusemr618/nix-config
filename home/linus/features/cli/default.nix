{ pkgs, lib, ... }: {
  imports = [
    ./btop.nix
    ./fish.nix
    ./git.nix
    ./neovim.nix
    ./python.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
  ];

  home.packages = with pkgs; [
    # Android tools
    android-tools
    
    # Development
    devenv
    
    # Modern CLI replacements
    bat          # Better cat
    eza          # Better ls
    fd           # Better find
    ripgrep      # Better grep
    fzf          # Fuzzy finder
    zoxide       # Better cd
    
    # System tools
    btop         # Better top
    duf          # Better df
    dust         # Better du
    procs        # Better ps
    
    # Network tools
    bandwhich    # Network bandwidth monitor
    
    # File management
    ranger       # Terminal file manager
    
    # Utilities
    jq           # JSON processor
    yq           # YAML processor
    tldr         # Simplified man pages
  ];

  # Configure bat with theme
  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      pager = "less -FR";
    };
  };

  # Configure eza (better ls)
  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    git = true;
    icons = true;
  };

  # Configure fzf
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    defaultCommand = "${pkgs.fd}/bin/fd --type f";
    defaultOptions = [
      "--height 40%"
      "--border"
      "--layout=reverse"
    ];
  };

  # Configure zoxide (better cd)
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  # Configure direnv for automatic environment loading
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  # Shell aliases
  home.shellAliases = {
    # Modern replacements
    cat = "bat";
    ls = "eza";
    ll = "eza -l";
    la = "eza -la";
    tree = "eza --tree";
    grep = "rg";
    find = "fd";
    
    # System shortcuts
    top = "btop";
    df = "duf";
    du = "dust";
    ps = "procs";
    
    # Git shortcuts
    g = "git";
    gs = "git status";
    ga = "git add";
    gc = "git commit";
    gp = "git push";
    gl = "git pull";
    gd = "git diff";
    gco = "git checkout";
    
    # NixOS shortcuts
    nr = "sudo nixos-rebuild switch --flake .";
    hm = "home-manager switch --flake .";
    nfu = "nix flake update";
    nfc = "nix flake check";
  };
}