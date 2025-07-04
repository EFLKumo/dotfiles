{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackagesConfig {
  inherit config pkgs;
  packagePaths = [
    [ "python3" ]
    [ "uv" ]
  ];
  optionPath = [
    "coding"
    "langs"
    "python"
  ];
}
