{
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  
  users.users = {
    linus = {
      initialPassword = "default";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        
      ];
      extraGroups = [ "wheel" "networkmanager" ];
    };
  };
  
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users.linus = {
      imports = [
        ../../../../home/linus
      ];
    };
  };
}
