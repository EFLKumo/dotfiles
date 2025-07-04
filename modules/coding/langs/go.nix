{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeSwitch {
  inherit config;
  optionName = "go";
  optionPath = [
    "coding"
    "langs"
    "go"
  ];
  config' = {
    my.persist.homeDirs = [
      "go"
    ];
    my.home.home.packages = with pkgs; [
      gopls
    ];
  };
}
