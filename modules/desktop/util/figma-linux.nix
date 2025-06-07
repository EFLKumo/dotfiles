{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackageConfig {
  inherit config pkgs;
  packageName = "figma-linux";
  packagePath = [
    "figma-linux"
  ];
  optionPath = [
    "desktop"
    "util"
    "figma-linux"
  ];
  extraConfig = {
    my.persist.homeDirs = [
      
    ];
  };
}
