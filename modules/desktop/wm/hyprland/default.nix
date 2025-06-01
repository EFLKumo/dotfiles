# TODO: Split

args@{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.my.desktop.wm.hyprland;
  types = import ./types.nix lib;
in
{
  options.my.desktop.wm.hyprland = {
    enable = lib.mkEnableOption "Hyprland";
    monitors = lib.mkOption {
      type = with lib.types; listOf types.monitor;
    };
    extraBinds = lib.mkOption {
      type = with lib.types; listOf types.bind;
      default = [ ];
    };
    extraExecs = lib.mkOption {
      type = with lib.types; listOf str;
      default = [ ];
    };
    extraExecOnces = lib.mkOption {
      type = with lib.types; listOf str;
      default = [ ];
    };
    extraEnvs = lib.mkOption {
      type = with lib.types; listOf types.env;
      default = [ ];
    };
  };

  imports = [
    (lib.mkIf cfg.enable (import ./config.nix args))
  ];

  config = lib.mkIf cfg.enable {
    programs.hyprland.enable = true;
    my.home = {
      wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;
        systemd.enable = true;
      };
      xdg.configFile."hyprsome/config.toml".text = ''
        monitors = [ ${
          builtins.concatStringsSep ", " (
            map (monitor: "\"${monitor.name}\"") (builtins.filter (monitor: !monitor.disable) cfg.monitors)
          )
        } ]
      '';

      home.packages = with pkgs; [
        wlr-randr
        wl-clipboard
        wl-clip-persist
        cliphist
        hyprshot
        hyprprop
        hyprsome
        swaynotificationcenter
        nemo-with-extensions
        pavucontrol
        pamixer
      ];
    };
  };
}
