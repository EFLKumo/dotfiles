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
    "tool"
    "reqable"
  ];
  persistHomeDirs = [ ".local/share/com.reqable.linux" ];
}
