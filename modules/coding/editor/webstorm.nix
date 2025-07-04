{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackageConfig {
  inherit config pkgs;
  packagePath = [
    "jetbrains"
    "webstorm"
  ];
  optionPath = [
    "coding"
    "editor"
    "webstorm"
  ];
  persistHomeDirs = [
    ".config/JetBrains"
    ".local/share/JetBrains"
  ];
}
