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
    "cli"
    "claude-code"
  ];
  extraConfig = {
    my.persist.homeDirs = [
      ".claude"
    ];
  };
}
