{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackagesConfig {
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
