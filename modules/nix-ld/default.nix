{
  config,
  lib,
  #pkgs,
  ...
}:
lib.my.makeNixOSProgramConfig {
  inherit config;
  optionPath = [
    "nix-ld"
  ];
  programConfig = {
    #libraries = with pkgs; [
    #
    #   ];
  };
}
