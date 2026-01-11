{
  users.users = {
    linus = {
      description = "Linus Emmerich";
      initialPassword = "default";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        
      ];
      extraGroups = [ "wheel" "networkmanager" ];
    };
  };
}