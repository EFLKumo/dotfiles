{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackageConfig {
  inherit config pkgs;
  packageName = "cherry-studio";
  packagePath = [
    "cherry-studio"
  ];
  optionPath = [
    "desktop"
    "util"
    "cherry-studio"
  ];
  extraConfig = {
    my.persist.homeDirs = [
      ".config/CherryStudio"
    ];
  };
}
