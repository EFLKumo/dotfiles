{
  lib,
  config,
  pkgs,
  username,
  ...
}:
let
  cfg = config.my.sops;
in
{
  options.my.sops = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    ageKeyFile = lib.mkOption {
      type = lib.types.str;
      default = "/persistent/home/${username}/.config/sops/age/keys.txt";
    };
  };

  config = lib.mkIf cfg.enable {
    sops.age.keyFile = cfg.ageKeyFile;
    users.users.${username}.extraGroups = [ "keys" ];
    environment.variables.SOPS_AGE_KEY_FILE = "/run/secrets.d/age-keys.txt";
    my.home = {
      sops.age.keyFile = cfg.ageKeyFile;
      home.packages = [
        pkgs.sops
      ];
    };
  };
}
