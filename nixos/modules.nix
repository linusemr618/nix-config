{ inputs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.omarchy-nix.nixosModules.default
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users.linus = {
      imports = [
        ../home-manager/home.nix
        inputs.omarchy-nix.homeManagerModules.default
      ];
    };
  };

  omarchy = {
    full_name = "Linus Emmerich";
    email_address = "emmerichlinus@gmail.com";
    theme = "tokyo-night";
  };
}
