{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackageConfig {
  inherit config pkgs;
  packageName = "baidupcs-go";
  packagePath = [ "baidupcs-go" ];
  optionPath = [
    "cli"
    "media"
    "baidupcs-go"
  ];
}
