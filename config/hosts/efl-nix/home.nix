{
  lib,
  pkgs,
  username,
  ...
}:
{
  my.home = {
    home.packages = with pkgs; [
      localsend

      wpsoffice-cn
      wps-office-fonts
      evince

      anki

      ayugram-desktop
      telegram-desktop
      signal-desktop
      qq

      gnome-clocks

      wineWowPackages.waylandFull

      pavucontrol
      pamixer
    ];

    programs.zsh = {
      sessionVariables = {
        PATH = "/home/${username}/bin:$PATH";
      };
      profileExtra = ''
        if [ `tty` = "/dev/tty6" ]; then
          clear
        fi
      '';
    };

    programs.niri.settings = {
      outputs = {
        eDP-1 = {
          enable = true;
          mode = {
            width = 2560;
            height = 1440;
            refresh = 60.0;
          };
          scale = 1.5;
          position = {
            x = 0;
            y = 0;
          };
        };
      };
    };

    programs.ssh = {
      enable = true;
      addKeysToAgent = "yes";
    };
  };

  my = {
    autologin = {
      enable = true;
      user = username;
      ttys = [ 6 ];
    };

    xdg = {
      enable = true;
      defaultApplications =
        let
          browser = [ "zen-beta.desktop" ];
          editor = [ "zed.desktop" ];
          imageviewer = [ "org.gnome.Shotwell-Viewer.desktop" ];
        in
        {
          "inode/directory" = [ "nemo.desktop" ];

          "application/pdf" = [ "org.gnome.Evince.desktop" ];

          "text/*" = editor;
          "application/json" = editor;
          "text/html" = editor;
          "text/xml" = editor;
          "application/xml" = editor;
          "application/xhtml+xml" = editor;
          "application/xhtml_xml" = editor;
          "application/rdf+xml" = editor;
          "application/rss+xml" = editor;
          "application/x-extension-htm" = editor;
          "application/x-extension-html" = editor;
          "application/x-extension-shtml" = editor;
          "application/x-extension-xht" = editor;
          "application/x-extension-xhtml" = editor;

          "x-scheme-handler/about" = browser;
          "x-scheme-handler/ftp" = browser;
          "x-scheme-handler/http" = browser;
          "x-scheme-handler/https" = browser;
          "x-scheme-handler/unknown" = browser;

          "audio/*" = imageviewer;
          "video/*" = imageviewer;
          "image/*" = imageviewer;
          "image/gif" = imageviewer;
          "image/jpeg" = imageviewer;
          "image/png" = imageviewer;
          "image/webp" = imageviewer;
        };
    };
    persist = {
      enable = true;
      homeDirs = [
        ".android"
        "Android"

        {
          directory = ".ssh";
          mode = "0700";
        }

        "bin"
        "workspace"
        "Downloads"
        "WineApps"
        "Virt"

        ".cache"
        ".local/state"
        ".local/share/Anki2"
        ".local/share/cheat.sh"
        ".local/share/dooit"
        ".local/share/Kingsoft"
        ".local/share/nvim"
        ".local/share/oss.krtirtho.spotube"
        ".local/share/shotwell"
        ".local/share/Steam"
        ".local/share/SteamOS"
        ".local/share/Trash"

        ".local/share/AyuGramDesktop"
        ".local/share/TelegramDesktop"
        ".config/Signal"
        ".config/QQ"

        ".config/sops"
        ".config/Kingsoft"
        ".config/dconf"
        ".config/gh"
        ".config/pulse"
        ".config/chromium"
        ".config/go-musicfox/db"
        ".config/tmux/plugins"
        ".config/pip"
        ".config/obs-studio"
        ".config/libreoffice"
        ".config/Moonlight Game Streaming Project"
        ".config/sunshine"
      ];
      nixosDirs = [
        "/etc/ssh"
        "/etc/NetworkManager/system-connections"
      ];
      homeFiles = [
        ".config/mpd/mpd.db" # requires bindfs
        ".config/go-musicfox/cookie"
        ".hmcl.json"
      ];
    };
  };
}
