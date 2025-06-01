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
        autoLogin.relogin = true;
      };
    };
  };
}
