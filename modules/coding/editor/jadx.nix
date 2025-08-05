{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackageConfig {
  inherit config pkgs;
  packagePath = [
    "jadx"
  ];
  optionPath = [
    "coding"
    "editor"
    "jadx"
  ];
  persistHomeDirs = [
  ];
}
