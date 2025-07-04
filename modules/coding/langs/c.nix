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
    "c"
  ];
  packagePaths = [
    [ "gcc" ]
    [ "clang-tools" ]
    [ "cmake" ]
  ];
}
