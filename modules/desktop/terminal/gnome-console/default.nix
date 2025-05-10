{ config, lib, ... }:
lib.my.makeHomeProgramConfig {
  inherit config;
  programName = "gnome-console";
  optionPath = [
    "desktop"
    "terminal"
    "gnome-console"
  ];
}
