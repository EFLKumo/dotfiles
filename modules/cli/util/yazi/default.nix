{
  config,
  lib,
  ...
}:
lib.my.makeHomeProgramConfig {
  inherit config;
  optionPath = [
    "cli"
    "util"
    "yazi"
  ];
  programConfig = {
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
}
