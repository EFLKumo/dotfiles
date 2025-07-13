{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackageConfig {
  inherit config pkgs;
  packageName = "dysk";
  packagePath = [ "dysk" ];
  optionPath = [
    "cli"
    "monitor"
    "dysk"
  ];
}
