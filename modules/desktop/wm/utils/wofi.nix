{ ... }:
{
  my.home = {
    programs.wofi.enable = true;
    xdg.configFile."wofi" = {
      source = ./wofi;
      recursive = true;
    };
    #xdg.configFile."wofi/style.css" = {
    #  source = ./wofi/everforest/style.css;
    #};
  };
}
