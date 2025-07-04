{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackagesConfig {
  inherit config pkgs;
  optionPath = [
    "coding"
    "misc"
  ];
  packagePaths = [
    [ "gnumake" ]
    [
      "github-cli" # gh
    ]
  ];
  persistHomeDirs = [
    ".local/share/direnv"
  ];
  extraConfig = {
    my.home = {
      programs.direnv.enable = true;
    };
  };
}
