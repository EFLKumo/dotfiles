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
  persistHomeDirs = [ ".local/share/com.reqable.linux" ];
}
