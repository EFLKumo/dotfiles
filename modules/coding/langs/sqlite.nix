{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackageConfig {
  inherit config pkgs;
  packageName = "sqlite";
  packagePath = [ "sqlite" ];
  optionPath = [
    "coding"
    "langs"
    "sqlite"
  ];
}
