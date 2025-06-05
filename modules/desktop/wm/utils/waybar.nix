{
  config,
  lib,
  pkgs,
  ...
}:
let
  baseWaybarConfig = import ./waybar/config.nix { inherit config lib pkgs; };

  makeWMConfig =
    wmType:
    let
      filteredModulesLeft = lib.filter (
        module: !(lib.hasPrefix "hyprland/workspaces" module) && !(lib.hasPrefix "niri/workspaces" module)
      ) baseWaybarConfig.modules-left;

      newModulesLeft = filteredModulesLeft ++ [
        (if wmType == "hyprland" then "hyprland/workspaces" else "niri/workspaces")
      ];
    in
    baseWaybarConfig
    // {
      modules-left = newModulesLeft;

      "hyprland/workspaces" =
        lib.mkIf (wmType == "hyprland")
          baseWaybarConfig."hyprland/workspaces" or { };
      "niri/workspaces" = lib.mkIf (wmType == "niri") baseWaybarConfig."niri/workspaces" or { };
    };

  hyprlandConfig = makeWMConfig "hyprland";
  niriConfig = makeWMConfig "niri";

  waybarWrapped = pkgs.symlinkJoin {
    name = "waybar-wrapped";
    paths = [ pkgs.waybar ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/waybar \
        --run '
          if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
            CFG=config-hyprland.jsonc
          elif [ -n "$NIRI_SOCKET" ]; then
            CFG=config-niri.jsonc
          else
            CFG=config-niri.jsonc
          fi

          exec $out/bin/waybar.real \
            -c "$HOME/.config/waybar/$CFG" \
            "$@"
        '
    '';
  };
in
{
  config = {
    my.home = {
      programs.waybar = {
        enable = true;
        package = waybarWrapped;
        systemd.enable = true;
      };

      xdg.configFile = {
        "waybar/config-hyprland.jsonc".text = builtins.toJSON hyprlandConfig;
        "waybar/config-niri.jsonc".text = builtins.toJSON niriConfig;
        "waybar/runtime-config.jsonc".text = "";

        "waybar/style.css".source = ./waybar/style.css;
      };
    };
  };
}
