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
    "vscode"
  ];
  programConfig.package = pkgs.vscodium;
  persistHomeDirs = [
    ".config/VSCodium"
    ".vscode-oss"
  ];
}
