{ config, lib, ... }:
lib.my.makeSwitch {
  inherit config;
  optionName = "all terminals";
  optionPath = [
    "desktop"
    "terminal"
    "all"
  ];
  config' = {
    my.desktop.terminal = {
      alacritty.enable = false;
      foot.enable = false;
      kitty.enable = true;
      ghostty.enable = false;
      gnome-console.enable = true;
    };
  };
}
