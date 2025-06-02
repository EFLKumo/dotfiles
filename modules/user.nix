{
  config,
  lib,
  pkgs,
  username,
  userDesc,
  sopsRoot,
  ...
}:
lib.my.makeSwitch {
  inherit config;
  default = true;
  optionName = "default user settings";
  optionPath = [ "user" ];
  config' = {
    programs.zsh.enable = true;

    sops.secrets.efl-nix-hashed-password = {
      sopsFile = sopsRoot + /efl-nix-hashed-password.txt;
      format = "binary";
      neededForUsers = true;
    };

    users = {
      mutableUsers = false;
      users.${username} = {
        isNormalUser = true;
        description = userDesc;
        shell = pkgs.zsh;
        extraGroups = [
          "wheel"
          username
        ];
        hashedPasswordFile = lib.mkDefault config.sops.secrets.efl-nix-hashed-password.path;
      };
      groups.${username} = { };
    };
    users.users.root.hashedPasswordFile = lib.mkDefault config.sops.secrets.efl-nix-hashed-password.path;

    security.sudo.extraRules = [
      {
        users = [ username ];
        commands = [
          {
            command = "ALL";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];

    nix.settings.trusted-users = [
      "root"
      username
    ];

    my.home = {
      home = {
        inherit username;
        homeDirectory = "/home/${username}";
      };
    };
  };
}
