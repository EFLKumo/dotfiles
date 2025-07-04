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
  optionName = "network proxy";
  optionPath = [
    "network-proxy"
  ];

  config' = {
    sops.secrets.dae = {
      sopsFile = sopsRoot + /dae.dae;
      format = "binary";
    };
    services.dae = {
      enable = true;
      configFile = config.sops.secrets.dae.path;
    };
    systemd.services.dae.after = [
      "sops-nix.service"
    ];

    sops.secrets.mihomo = {
      sopsFile = sopsRoot + /mihomo.yaml;
      format = "yaml";
      key = "";
    };
    systemd.services.mihomo = {
      after = [
        "network.target"
        "network-online.target"
        "sops-nix.service"
      ];
      wants = [ "network-online.target" ];
    };
    services.mihomo = {
      enable = true;
      configFile = config.sops.secrets.mihomo.path;
      tunMode = false;
      webui = pkgs.metacubexd;
    };

    services.sing-box = {
      enable = false;
      settings = {

      };
    };
  };
}
