{ config, lib, ... }:
lib.my.makeSwitch {
  inherit config;
  optionName = "all coding programs";
  optionPath = [
    "coding"
    "all"
  ];
  config' = {
    my.coding = {
      editor.all.enable = true;
      langs.all.enable = true;
      tools.all.enable = true;
      misc.enable = true;
    };
  };
}
