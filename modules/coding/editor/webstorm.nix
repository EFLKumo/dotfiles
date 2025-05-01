{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackageConfig {
  inherit config pkgs;
  packageName = "webstorm";
  packagePath = [
    "jetbrains"
    "webstorm"
  ];
  optionPath = [
    "coding"
    "editor"
    "webstorm"
  ];
  extraConfig = {
    my.persist.homeDirs = [

    ];
  };
}
