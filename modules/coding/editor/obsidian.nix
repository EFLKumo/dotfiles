{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackageConfig {
  inherit config pkgs;
  packagePath = [ "obsidian" ];
  optionPath = [
    "coding"
    "editor"
    "obsidian"
  ];
  persistHomeDirs = [ ".config/obsidian" ];
}
