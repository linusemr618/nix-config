{pkgs, ...}: {
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cpu;
    loadModels = ["gemma4:e4b"];
  };

  services.open-webui = {
    enable = true;
  };
}
