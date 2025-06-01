{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = {
    my.home = {
      programs.waybar = {
        enable = true;
        systemd.enable = true;
      };

      xdg.configFile = {
        "waybar/config.jsonc".text = builtins.toJSON (
          import ./waybar/config.nix { inherit config lib pkgs; }
        );
        "waybar/style.css".source = ./waybar/style.css;
      };
    };
  };
}
