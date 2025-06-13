{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeSwitch {
  inherit config;
  optionName = "nix";
  optionPath = [
    "coding"
    "langs"
    "nix"
  ];
  config' = {
    my.home.home.packages = with pkgs; [
      nixd
      nil
    ];
  };
}
