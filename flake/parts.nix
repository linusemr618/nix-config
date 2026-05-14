{inputs, ...}: {
  imports = [
    inputs.home-manager.flakeModules.home-manager
    inputs.wrapper-modules.flakeModules.wrappers
  ];
  config = {
    systems = [
      "x86_64-linux"
    ];
  };
}
