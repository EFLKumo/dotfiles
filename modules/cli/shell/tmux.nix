{
  config,
  pkgs,
  lib,
  ...
}:
lib.my.makeSwitch {
  inherit config;
  default = true;
  optionName = "tmux";
  optionPath = [
    "cli"
    "shell"
    "tmux"
  ];

  config' = {
    programs.tmux = {
      enable = true;
      extraConfig = "set-option -g mouse on";
      plugins = [
        (pkgs.tmuxPlugins.mkTmuxPlugin {
          pluginName = "tokyo-night-tmux";
          rtpFilePath = "tokyo-night.tmux";
          version = "legacy";
          src = pkgs.fetchFromGitHub {
            owner = "janoamaral";
            repo = "tokyo-night-tmux";
            rev = "16469dfad86846138f594ceec780db27039c06cd";
            hash = "sha256-EKCgYan0WayXnkSb2fDJxookdBLW0XBKi2hf/YISwJE=";
          };
        })
      ];
    };
  };
}
