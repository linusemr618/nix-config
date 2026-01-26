{
  pkgs,
  ...
}: {
  imports = [
    
  ];

  home.packages = with pkgs; [
    dconf-editor
    gnome-boxes
    proton-pass
  ];
}