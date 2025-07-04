{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomeProgramConfig {
  inherit config;
  optionPath = [
    "coding"
    "editor"
    "zed-editor"
  ];
  programConfig.package = pkgs.zed-editor;
  persistHomeDirs = [
    ".config/zed"
    ".local/share/zed"
  ];
}
