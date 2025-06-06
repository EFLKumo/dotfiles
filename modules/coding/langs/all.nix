{ config, lib, ... }:
lib.my.makeSwitch {
  inherit config;
  optionName = "all coding langs";
  optionPath = [
    "coding"
    "langs"
    "all"
  ];
  config' = {
    my.coding.langs = {
      c.enable = false;
      go.enable = false;
      js.enable = true;
      python.enable = true;
      rust.enable = true;
      lua.enable = true;
      sqlite.enable = true;
    };
  };
}
