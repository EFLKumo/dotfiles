{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackageConfig {
  inherit config pkgs;
  packageName = "claude-code";
  packagePath = [ "claude-code" ];
  optionPath = [
    "coding"
    "tools"
    "claude-code"
  ];
  persistHomeDirs = [
    ".claude"
    ".claude-code-router" # npm: claude-code-router
  ];
}
