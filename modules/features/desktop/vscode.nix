{
  flake.homeModules.desktop = {pkgs, ...}: {
    programs.vscode.enable = true;
    home.packages = with pkgs; [
      alejandra
      nixd
    ];
  };
}
