{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackageConfig {
  inherit config pkgs;
  packageName = "keyguard";
  packagePath = [
    "keyguard"
  ];
  optionPath = [
    "desktop"
    "util"
    "keyguard"
  ];
  extraConfig = {
    my.persist.homeDirs = [

    ];
  };
}
