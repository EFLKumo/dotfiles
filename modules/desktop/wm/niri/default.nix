args@{
  lib,
  config,
  pkgs,
  username,
  ...
}:
let
  cfg = config.my.desktop.wm.niri;
  pkg = pkgs.niri-unstable;
in
{
  options.my.desktop.wm.niri = {
    enable = lib.mkEnableOption "Niri";
  };

  imports = [
    (lib.mkIf cfg.enable (import ./config.nix args))
  ];

  config = lib.mkIf cfg.enable {
    xdg.portal.config = {
      niri = {
        default = [
          "gnome"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Access" = [ "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
        "org.freedesktop.impl.portal.Notification" = [ "gtk" ];
        "org.freedesktop.impl.portal.RemoteDesktop" = [ "gnome" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      };
    };
    programs.niri = {
      enable = true;
      package = pkg;
    };

    my.home = {
      home.packages = with pkgs; [
        wlr-randr
        wl-clipboard
        # wl-clip-persist
        cliphist
        swaynotificationcenter
        nemo-with-extensions
      ];
      programs.wofi.enable = true;
    };
  };
}
