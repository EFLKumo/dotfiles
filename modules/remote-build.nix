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
        Restart = lib.mkOverride 500 "always";
        RestartMaxDelaySec = lib.mkOverride 500 "1m";
        RestartSec = lib.mkOverride 500 "100ms";
        RestartSteps = lib.mkOverride 500 9;
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
