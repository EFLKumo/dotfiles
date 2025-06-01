{
  config,
  lib,
  username,
  ...
}:
{
  config = {
    services.displayManager = {
      autoLogin = {
        enable = true;
        user = username;
      };
      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "where_is_my_sddm_theme";
        extraPackages = [
          (pkgs.where-is-my-sddm-theme.override {
            variants = [ "qt6" ];
            themeConfig.General = {
              background = toString ../wallpaper.jpg;
            };
          })
        ];
      };
    };
  };
}
