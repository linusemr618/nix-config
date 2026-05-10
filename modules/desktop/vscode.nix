{
  flake.homeModules.desktop = {pkgs, ...}: {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      profiles.default = {
        enableExtensionUpdateCheck = false;
        enableUpdateCheck = false;
        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide

          ms-vscode.cmake-tools
          ms-vscode.cpptools
          ms-vscode.cpptools-extension-pack

          tomoki1207.pdf
        ];
        userSettings = {
          "files.autoSave" = "onFocusChange";
          "git.confirmSync" = false;
          "git.autofetch" = true;
          "git.enableSmartCommit" = true;
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          "nix.formatterPath" = "alejandra";
          "nix.hiddenLanguageServerErrors" = ["textDocument/definition" "textDocument/formatting"];
          "nix.serverSettings" = {
            "nixd" = {
              "formatting" = {
                "command" = [
                  "alejandra"
                ];
              };
            };
          };
          "[nix]"."editor.formatOnSave" = true;
          "[nix]"."editor.tabSize" = 2;
        };
      };
    };
    home.packages = with pkgs; [
      alejandra
      nixd
    ];

    xdg.configFile."autostart/code.desktop".source = "${pkgs.vscode}/share/applications/code.desktop";
  };
}
