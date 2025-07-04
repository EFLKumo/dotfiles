{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackagesConfig {
  inherit config pkgs;
  optionPath = [
    "coding"
    "langs"
    "go"
  ];
  packagePaths = [
    [ "gopls" ]
  ];
  persistHomeDirs = [ "go" ];
}
