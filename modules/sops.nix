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
    sshKeyPaths = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "/persistent/home/${username}/.ssh/github_ed25519"
        "/persistent/home/${username}/.ssh/imxyy"
      ];
    };
  };

  config = lib.mkIf cfg.enable {
    sops.age.keyFile = cfg.ageKeyFile;
    sops.age.sshKeyPaths = cfg.sshKeyPaths;
    users.users.${username}.extraGroups = [ "keys" ];
    environment.variables.SOPS_AGE_KEY_FILE = "/run/secrets.d/age-keys.txt";
    my.home = {
      sops.age.keyFile = cfg.ageKeyFile;
      sops.age.sshKeyPaths = [
        cfg.sshKeyPath
      ];
      home.packages = [
        pkgs.sops
      ];
    };
  };
}
