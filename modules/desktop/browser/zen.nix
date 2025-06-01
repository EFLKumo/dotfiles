{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomeProgramConfig {
  inherit config;
  programName = "zen-browser";
  optionPath = [
    "desktop"
    "browser"
    "zen"
  ];
  extraConfig = {
    my.home.programs.zen-browser = {
      enable = true;
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
      };
      nativeMessagingHosts = [ pkgs.firefoxpwa ];
    };
    my.persist.homeDirs = [
      ".zen"
    ];
  };
}
