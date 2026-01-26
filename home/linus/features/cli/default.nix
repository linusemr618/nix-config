{
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./git.nix
    ./neovim.nix
  ];

  home.packages = with pkgs; [
    # Stable packages (from nixpkgs stable channel)
    android-tools
    python3
  ] ++ (with pkgs-unstable; [
    # Unstable packages (from nixpkgs-unstable channel)
    # Add packages here that you want from unstable
    # Example: pkgs-unstable.some-bleeding-edge-tool
  ]);
}
