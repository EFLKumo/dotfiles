{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackageConfig {
  inherit config pkgs;
  packageName = "xmind";
  packagePath = [
    "xmind"
  ];
  optionPath = [
    "desktop"
    "util"
    "xmind"
  ];
  extraConfig = {
    my.persist.homeDirs = [

    ];
  };
}
