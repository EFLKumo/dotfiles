{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackageConfig {
  inherit config pkgs;
  optionPath = [
    "desktop"
    "wine"
  ];
  packagePaths = [
    [ "wineWayland" ]
    [ "proton-ge-custom" ]
    [ "bottles" ]
  ];
  persistHomeDirs = [
    ".local/share/bottles"
  ];
}
