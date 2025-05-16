{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackageConfig {
  inherit config pkgs;
  packageName = "notion-app";
  packagePath = [
    "notion-app"
  ];
  optionPath = [
    "coding"
    "editor"
    "notion-app"
  ];
  extraConfig = {
    my.persist.homeDirs = [

    ];
  };
}
