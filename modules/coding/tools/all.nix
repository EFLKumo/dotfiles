{ config, lib, ... }:
lib.my.makeSwitch {
  inherit config;
  optionName = "all coding tools";
  optionPath = [
    "coding"
    "tools"
    "all"
  ];
  config' = {
    my.coding.tools = {
      reqable.enable = true;
      asar.enable = true;
      package-version-server.enable = true;
    };
  };
}
