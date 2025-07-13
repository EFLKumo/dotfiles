{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackageConfig {
  inherit config pkgs;
  packageName = "package-version-server";
  packagePath = [
    "package-version-server"
  ];
  optionPath = [
    "coding"
    "tools"
    "package-version-server"
  ];
}
