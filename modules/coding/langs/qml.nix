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
    "langs"
    "qml"
  ];
  packagePaths = [
    [
      "kdePackages"
      "qtdeclarative"
    ]
  ];
}
