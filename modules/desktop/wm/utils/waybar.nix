{
  pkgs,
  ...
}:
let
  waybarConfig = import ./waybar/tokyo-night/config.nix;

  waybarWrapped = pkgs.symlinkJoin {
    name = "waybar-wrapped";
    paths = [ pkgs.waybar ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/waybar \
        --run '
          CONFIG_DIR="$HOME/.config/waybar"
          CFG="$CONFIG_DIR/config.jsonc"
          set -- -c "$CFG" "$@"
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
        "waybar/config.jsonc".text = builtins.toJSON waybarConfig;
        "waybar/style.css".source = ./waybar/tokyo-night/style.css;
      };
    };
  };
}
