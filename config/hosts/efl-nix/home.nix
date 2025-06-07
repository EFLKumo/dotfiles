{
  config,
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

      telegram-desktop
      signal-desktop
      discord
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
        DP-2 = {
          enable = true;
          mode = {
            width = 2560;
            height = 1440;
            refresh = 75.033;
          };
          scale = 1.25;
          position = {
            x = 0;
            y = 0;
          };
        };
        DP-3 = {
          enable = true;
          mode = {
            width = 2560;
            height = 1440;
            refresh = 75.033;
          };
          scale = 1.25;
        };
      };
      spawn-at-startup = [
        {
          command = [
            "sh"
            "-c"
            "sleep 3; echo 'Xft.dpi: 120' | ${lib.getExe pkgs.xorg.xrdb} -merge"
          ];
        }
      ];
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

    gpg.enable = true;
    cli.all.enable = true;
    coding.all.enable = true;
    desktop.all.enable = true;

    i18n.fcitx5.enable = true;

    desktop.wm.hyprland.monitors = [
      {
        name = "preferred";
        resolution = "2240x1400";
        position = "0x0";
        scale = "1.5";
      }
    ];

    xdg = {
      enable = true;
      defaultApplications =
        let
          browser = [ "zen-beta.desktop" ];
          editor = [ "codium.desktop" ];
          imageviewer = [ "org.gnome.Shotwell-Viewer.desktop" ];
        in
        {
          "inode/directory" = [ "nemo.desktop" ];

          "application/pdf" = [ "evince.desktop" ];

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
        ".local/share/keyrings"
        ".local/share/Kingsoft"
        ".local/share/nvim"
        ".local/share/oss.krtirtho.spotube"
        ".local/share/shotwell"
        ".local/share/Steam"
        ".local/share/SteamOS"
        ".local/share/Trash"

        ".local/share/TelegramDesktop"
        ".config/Signal"
        ".config/discord"
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
