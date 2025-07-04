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
    "nix"
  ];
  packagePaths = [
    [ "nixd" ]
    [ "nil" ]
  ];
}
