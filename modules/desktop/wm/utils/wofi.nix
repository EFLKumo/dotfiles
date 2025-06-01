{ ... }:
{
  my.home = {
    programs.wofi.enable = true;
    xdg.configFile."wofi" = {
      source = ./wofi;
      recursive = true;
    };
  };
}
