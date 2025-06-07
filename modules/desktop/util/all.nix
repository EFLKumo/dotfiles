{ config, lib, ... }:
lib.my.makeSwitch {
  inherit config;
  optionName = "all utilities";
  optionPath = [
    "desktop"
    "util"
    "all"
  ];
  config' = {
    my.desktop.util = {
      cherry-studio.enable = true;
      figma-linux.enable = true;
      xmind.enable = true;
    };
  };
}
