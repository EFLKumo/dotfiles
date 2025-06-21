{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackageConfig {
  inherit config pkgs;
  packageName = "onlyoffice-desktopeditors";
  packagePath = [ "onlyoffice-desktopeditors" ];
  optionPath = [
    "desktop"
    "media"
    "onlyoffice"
  ];
}
