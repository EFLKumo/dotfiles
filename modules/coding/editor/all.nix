{ config, lib, ... }:
lib.my.makeSwitch {
  inherit config;
  optionName = "all coding editors";
  optionPath = [
    "coding"
    "editor"
    "all"
  ];
  config' = {
    my.coding.editor = {
      neovim.enable = true;
      vscode.enable = true;
      webstorm.enable = false;
      obsidian.enable = true;
      zed-editor.enable = true;
      notion-app.enable = false;
    };
  };
}
