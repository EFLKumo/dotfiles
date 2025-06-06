{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeSwitch {
  inherit config;
  optionName = "misc";
  optionPath = [
    "coding"
    "misc"
  ];
  config' = {
    my.home = {
      home.packages = with pkgs; [
        gnumake
        github-cli # gh
      ];
      programs.zsh.initContent = lib.mkBefore ''
        source ${./github-cli-comp}
      '';
      programs.direnv.enable = true;
    };
    my.persist.homeDirs = [
      ".local/share/direnv"
    ];
  };
}
