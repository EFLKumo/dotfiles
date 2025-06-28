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
    "tool"
    "claude-code"
  ];
  extraConfig = {
    my.persist.homeDirs = [
      ".claude"
      ".claude-code-router" # npm: claude-code-router
    ];
  };
}
