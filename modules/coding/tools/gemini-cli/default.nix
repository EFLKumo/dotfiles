{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackageConfig {
  inherit config pkgs;
  packagePath = [ "gemini-cli" ];
  optionPath = [
    "coding"
    "tools"
    "gemini-cli"
  ];
  persistHomeDirs = [
    ".gemini"
  ];
}
