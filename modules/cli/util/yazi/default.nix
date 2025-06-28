{
  config,
  lib,
  ...
}:
lib.my.makeSwitch {
  inherit config;
  default = true;
  optionName = "yazi";
  optionPath = [
    "cli"
    "util"
    "yazi"
  ];
  config' = {
    my.home = {
      programs.yazi = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          log.enabled = false;
          mgr = {
            ratio = [
              3
              9
              8
            ];
            sort_sensitive = true;
            sort_dir_first = true;
            show_hidden = true;
            show_symlink = true;
          };
        };
      };
    };
  };
}
