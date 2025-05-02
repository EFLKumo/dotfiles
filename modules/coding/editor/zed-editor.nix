{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomeProgramConfig {
  inherit config;
  programName = "zed-editor";
  optionPath = [
    "coding"
    "editor"
    "zed-editor"
  ];
  extraConfig = {
    my.home = {
      programs.zed-editor = {
        enable = true;
        package = pkgs.zed-editor;
      };
    };
    my.persist.homeDirs = [
      ".config/zed"
      ".local/share/zed"
    ];
  };
}
