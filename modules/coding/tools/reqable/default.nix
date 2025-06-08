{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackageConfig {
  inherit config pkgs;
  packageName = "reqable";
  packagePath = [
    "reqable"
  ];
  optionPath = [
    "coding"
    "tools"
    "reqable"
  ];
  extraConfig = {
    my.persist.homeDirs = [
      ".local/share/com.reqable.linux"
    ];
  };
}
