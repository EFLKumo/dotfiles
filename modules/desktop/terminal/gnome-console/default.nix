{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackageConfig {
  inherit config pkgs;
  packageName = "gnome-console";
  packagePath = [ "gnome-console" ];
  optionPath = [
    "desktop"
    "terminal"
    "gnome-console"
  ];
}
