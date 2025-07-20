{
  config,
  lib,
  sopsRoot,
  ...
}:
lib.my.makeSwitch {
  inherit config;
  default = false;
  optionName = "network proxy";
  optionPath = [
    "network-proxy"
  ];

  config' = {
    sops.secrets.dae = {
      path = "/etc/dae/config.dae";
      sopsFile = sopsRoot + /config.dae;
      format = "binary";
    };

    services.dae = {
      enable = true;
      configFile = config.sops.secrets.dae.path;
    };
    systemd.services.dae.after = [
      "sops-nix.service"
    ];

    my.persist.nixosDirs = [ "/etc/dae" ];
  };
}
