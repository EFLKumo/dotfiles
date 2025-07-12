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
  programConfig = {
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
    };
    nativeMessagingHosts = [ pkgs.firefoxpwa ];
  };
  persistHomeDirs = [
    ".zen"
  ];
}
