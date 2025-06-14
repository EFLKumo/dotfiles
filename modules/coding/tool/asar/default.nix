{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackageConfig {
  inherit config pkgs;
  packageName = "asar";
  packagePath = [
    "asar"
  ];
  optionPath = [
    "coding"
    "tool"
    "asar"
  ];
}
