{ pkgs, ... }: {
  programs.nix-ld = {
    enable = true;
  };
  environment.variables = {
    LD_LIBRARY_PATH = "$LD_LIBRARY_PATH\${LD_LIBRARY_PATH:+:}$NIX_LD_LIBRARY_PATH";
  };
}