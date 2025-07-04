{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackageConfig {
  inherit config pkgs;
  optionPath = [
    "coding"
    "langs"
    "lua"
  ];
  packagePath = [ "luajit" ];
}
