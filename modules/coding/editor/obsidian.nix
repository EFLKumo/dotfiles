{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackageConfig {
  inherit config pkgs;
  packageName = "obsidian";
  packagePath = [ "obsidian" ];
  optionPath = [
    "coding"
    "editor"
    "obsidian"
  ];
  extraConfig = {
    my.persist.homeDirs = [
      ".config/obsidian"
    ];
  };
}
