{
  config,
  lib,
  pkgs,
  sopsRoot,
  ...
}:
lib.my.makeSwitch {
  inherit config;
  default = false;
  optionName = "use remote server to build NixOS";
  optionPath = [
    "remote-build"
  ];

  config' = {
    sops.secrets.et-nixremote = {
      sopsFile = sopsRoot + /peers.toml;
      format = "binary";
    };
    environment.systemPackages = [
      pkgs.easytier
    ];
    systemd.services."easytier-nixremote" = {
      enable = true;
      script = "${pkgs.easytier}/bin/easytier-core -c ${config.sops.secrets.et-nixremote.path}";
      serviceConfig = {
        Restart = "always";
        RestartSec = 30;
        User = "root";
      };
      wantedBy = [ "multi-user.target" ];
      after = [
        "network.target"
        "sops-nix.service"
      ];
    };
  };
}
