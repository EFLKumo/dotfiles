{
  config,
  lib,
  pkgs,
  ...
}:
let
  # WARNING:
  # pkg = p: lib.getExe pkgs.${p};
  pkg = p: lib.getExe' pkgs.${p} p;
  pkg' = p: n: lib.getExe' pkgs.${p} n;
  cfg = config.my.desktop.wm.hyprland;
  zip =
    a: b:
    let
      aLen = builtins.length a;
      bLen = builtins.length b;
      len = if aLen > bLen then aLen else bLen;
    in
    builtins.genList (idx: {
      first = builtins.elemAt a idx;
      second = builtins.elemAt b idx;
    }) len;
  enumerate =
    list:
    map (
      { first, second }:
      {
        index = first;
        item = second;
      }
    ) (zip (lib.range 0 (builtins.length list - 1)) list);
  scripts = {
    menu = "pkill wofi || wofi --color ~/.config/wal/colors";
    clip = "pkill wofi || cliphist list | wofi --dmenu --color ~/.config/wal/colors | cliphist decode | wl-copy";
    typer = "pgrep zenity || (file=$(mktemp); zenity --entry --title 'Typer' --width 600 --height 200 > $file & sleep 0.3; fcitx5-remote -o; wait; head -c -1 $file | wl-copy)";
    musicfox =
      silent:
      "if [ -x $(pgrep musicfox) ]; then hyprctl dispatch exec '[workspace special:media${
        if silent then " silent" else ""
      }] kitty musicfox'; ${
        if !silent then "else hyprctl dispatch togglespecialworkspace media;" else ""
      } fi";
    todo =
      silent:
      "if [ -x $(pgrep dooit) ]; then hyprctl dispatch exec '[workspace special:todo${
        if silent then " silent" else ""
      }] kitty dooit'; ${
        if !silent then "else hyprctl dispatch togglespecialworkspace todo;" else ""
      } fi";
  };
in
{
  my.home.wayland.windowManager.hyprland = {
    systemd.enable = true;

    settings = {
      monitor = map (
        {
          name,
          resolution,
          position,
          disable,
          scale,
          mirror,
          vrr,
          rotate,
          ...
        }@monitor:
        if !disable then
          "${name}, ${resolution}, ${position}, ${scale}"
          + (lib.optionalString (mirror != null) ", mirror, ${mirror}")
          + (lib.optionalString monitor."10bit" ", bitdepth, 10")
          + (lib.optionalString (vrr != null) ", vrr, ${toString vrr}")
          + (lib.optionalString (rotate != null) ", transform, ${toString rotate}")
        else
          "${name}, disable"
      ) cfg.monitors;

      workspace = builtins.concatLists (
        map (
          { index, item }:
          let
            nummon = index;
            mon = item.name;
          in
          map (numspace: "${toString (nummon * 10 + numspace)}, monitor:${mon}, persistent:true") (
            lib.range 1 10
          )
        ) (enumerate (builtins.filter (monitor: !monitor.disable) cfg.monitors))
      );

      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        touchpad.natural_scroll = "yes";

        sensitivity = 0;
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 3;
        "col.active_border" = "rgba(6186d6ee) rgba(cba6f7ee) 90deg";
        "col.inactive_border" = "rgba(2e2e3eee)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 20;
        blur = {
          enabled = true;
          size = 4;
          passes = 4;
          new_optimizations = true;
          xray = false;
          ignore_opacity = true;
          special = true;
        };
        dim_special = 0;
      };

      animations = {
        enabled = "yes";
        bezier = [
          "overshot, 0.13, 0.99, 0.29, 1.1"
          "workspace, 0, 1.11, 0.6, 1.01"
        ];
        animation = [
          "windowsOut, 1, 5, overshot, slide"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "windows, 1, 5, overshot, slide"
          "windowsMove, 1, 5, overshot,"
          "fade, 1, 10, default"
          "workspaces, 1, 5, workspace, slidevert"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        special_scale_factor = 0.9;
      };

      master = {
        orientation = "left";
        special_scale_factor = 0.9;
      };

      gestures = {
        workspace_swipe = "off";
      };

      xwayland = {
        force_zero_scaling = true;
      };

      misc = {
        enable_swallow = true;
        swallow_regex = "^(ft)$";
        new_window_takes_over_fullscreen = 2;
        force_default_wallpaper = 0;
      };

      debug = {
        disable_logs = false;
        enable_stdout_logs = true;
      };

      layerrule = [
        "blur, waybar"
        "ignorezero, waybar"

        "blur, swaync-notification-window"
        "ignorezero, swaync-notification-window"
        "blur, swaync-control-center"
        "ignorezero, swaync-control-center"
      ];

      windowrulev2 = [
        "float, class:^(ft|sp)$"
        "pin, class:^(sp)$"
        "noblur, xwayland:1, floating:1, class:^()$, title: ^()$"
        "float, class:^(nemo)$, title:^(.*\sProperties)$"
        "float, class:^(nemo)$, title:^(.*\s属性)$"
        "float, class:^(Clash for Windows)$"
        "center, class:^(Clash for Windows)$"
        "center, class:^(QQ)$, title:^(QQ)$"
        "center, class:^(Qq)$"
        "opacity 0.8 0.8, class:^(chromium-browser)$"
        "opacity 0.8 0.8, class:^(firefox)$"
        "opacity 0.7 0.7, class:^(org.gnome.Nautilus)$"
        "opacity 0.6 0.6, class:^(nemo)$"
        "opacity 0.7 0.7, class:^(musicfox)$"
        "opacity 0.7 0.7, class:^(spotify)$"
        "opacity 0.8 0.8, class:^(st-256color|ft|sp|kitty|foot|footclient|Alacritty|neovide)$"
        "tile, class:^(wps|wpp|et|wpspdf)$, title:^.*WPS\s*(演示|文字|表格|PDF|2019)$"
        "noanim, class:^(wps|wpp|et|wpspdf)$, title:^(wps|wpp|et|wpspdf)$"
        "noborder, class:^(wps|wpp|et|wpspdf)$, title:^(wps|wpp|et|wpspdf)$"
        "noblur, class:^(wps|wpp|et|wpspdf)$, title:^(wps|wpp|et|wpspdf)$"
        "rounding 0, class:^(wps|wpp|et|wpspdf)$, title:^(wps|wpp|et|wpspdf)$"
        "suppressevent maximize, class:^(libreoffice-.*)$"
        "float, class:^(cava)$"
        "move 6 50, class:^(cava)$"
        "size 290 165, class:^(cava)$"
        "nofocus, class:^(cava)$"
        "pin, class:^(cava)$"
        "opacity 0.7 0.7, class:^(cava)$"
        "noborder, class:^(cava)$"
        "noborder, class:^(org\.jackhuang\.hmcl\.Launcher)$"
        "noblur, class:^(org\.jackhuang\.hmcl\.Launcher)$"
        "float, class:^(Lunar\sClient\s1\.8\.9.*)$"
        "float, class:^(org\.kde\.kdialog)$"
        "float, class:^(org\.kde\.polkit-kde-authentication-agent-1)$"
        "stayfocused, class:^(org\.kde\.polkit-kde-authentication-agent-1)$"
        "float, title:^(Steam\sTyper)$"
        "pin, title:^(Steam\sTyper)$"
        "stayfocused, title:^(Steam\sTyper)$"
        "pin, class:^(wofi)$"
        "stayfocused, class:^(wofi)$"
        "pin, class:^(rofi)$"
        "stayfocused, class:^(rofi)$"
        "pin, class:^(polkit-gnome-authentication-agent-1)$"
        "stayfocused, class:^(polkit-gnome-authentication-agent-1)$"
        "float, class:^(blueman-manager)$"
        "float, class:^(org.gnome.clocks)$"
        "float, class:^(pavucontrol)$"
        "nofocus, title:^(notificationtoasts_32_desktop)$"
        "noinitialfocus, title:^(notificationtoasts_32_desktop)$"
        "float, class:^(firefox)$, title:^(Firefox — 共享指示器)$"
        "suppressevent maximize, class:^(firefox)$, title:^(Firefox — 共享指示器)$"
        "float, class:^(firefox)$, title:^(Firefox)$"
        "suppressevent maximize, class:^(firefox)$, title:^(Firefox)$"
        "rounding 0, class:^(showmethekey-gtk)$"
        "noborder, class:^(showmethekey-gtk)$"
        "pin, class:^(showmethekey-gtk)$"
        "stayfocused, class:^(org.gnome.Nautilus)$, title:^(新建文件夹)$"
        "float, class:^(ADanceOfFireAndIce)$"
        "noblur, class:^fcitx.*, xwayland:1"
        "noanim, class:^fcitx.*, xwayland:1"
      ];

      bind =
        [
          "CTRL ALT, T, exec, kitty"
          "SUPER, Return, exec, kitty --app-id=ft"
          "CTRL ALT, Return, exec, kitty --app-id=sp"
          "SUPER, Z, exec, zen"
          "SUPER, E, exec, ${lib.getExe pkgs.nemo-with-extensions}"
          "SUPER, D, exec, codium --enable-wayland-ime --wayland-text-input-version=3 --ozone-platform=wayland"
          "SUPER, R, exec, ${scripts.menu}"
          "SUPER, V, exec, ${scripts.clip}"
          "SUPER, Q, killactive"
          "SUPER, escape, exec, ${pkg "wlogout"}"

          "SUPER, F, togglefloating,"
          "SUPER, M, fullscreen, 1"
          "SUPER SHIFT, M, fullscreen, 0"
          "SUPER, P, pseudo,"

          "SUPER, T, exec, ${scripts.typer}"
          "SUPER, End, exec, ${pkgs.swaynotificationcenter + /bin/swaync-client} -t -sw"
          "CTRL ALT, K, exec, hyprctl kill"

          ", XF86AudioRaiseVolume, exec, ${pkg "pamixer"} -i 2"
          ", XF86AudioLowerVolume, exec, ${pkg "pamixer"} -d 2"
          ", XF86AudioMute, exec, ${pkg "playerctl"} -i firefox,chromium play-pause"
          "SUPER, XF86AudioRaiseVolume, exec, ${pkg "playerctl"} -i firefox,chromium next"
          "SUPER, XF86AudioLowerVolume, exec, ${pkg "playerctl"} -i firefox,chromium previous"

          "CTRL ALT, A, exec, ${pkg "hyprshot"} -m region --clipboard-only"
          "CTRL SHIFT ALT, A, exec, ${pkg "hyprshot"} -m region --output-folder ~/Pictures -- ${pkg "shotwell"}"
          ", PRINT, exec, ${pkg "hyprshot"} -m output --output-folder ~/Pictures"
          "ALT, PRINT, exec, ${pkg "hyprshot"} -m window --output-folder ~/Pictures"

          "SUPER, H, togglespecialworkspace, hidden"
          "SUPER SHIFT, H, movetoworkspacesilent, special:hidden"
          "SUPER, mouse:274, movetoworkspacesilent, +0"

          "SUPER, N, exec, ${scripts.todo false}"

          "ALT, Tab, layoutmsg, cyclenext"
          "ALT SHIFT, Tab, layoutmsg, cycleprev"

          "SUPER, left, movefocus, l"
          "SUPER, right, movefocus, r"
          "SUPER, up, movefocus, u"
          "SUPER, down, movefocus, d"

          "SUPER CTRL SHIFT, left, movewindow, l"
          "SUPER CTRL SHIFT, right, movewindow, r"
          "SUPER CTRL SHIFT, up, movewindow, u"
          "SUPER CTRL SHIFT, down, movewindow, d"

          "SUPER ALT, left, moveactive, -40 0"
          "SUPER ALT, right, moveactive, 40 0"
          "SUPER ALT, up, moveactive, 0 -40"
          "SUPER ALT, down, moveactive, 0 40"

          "SUPER, 1, exec, ${pkg "hyprsome"} workspace 1"
          "SUPER, 2, exec, ${pkg "hyprsome"} workspace 2"
          "SUPER, 3, exec, ${pkg "hyprsome"} workspace 3"
          "SUPER, 4, exec, ${pkg "hyprsome"} workspace 4"
          "SUPER, 5, exec, ${pkg "hyprsome"} workspace 5"
          "SUPER, 6, exec, ${pkg "hyprsome"} workspace 6"
          "SUPER, 7, exec, ${pkg "hyprsome"} workspace 7"
          "SUPER, 8, exec, ${pkg "hyprsome"} workspace 8"
          "SUPER, 9, exec, ${pkg "hyprsome"} workspace 9"
          "SUPER, 0, exec, ${pkg "hyprsome"} workspace 10"

          "SUPER SHIFT, 1, exec, ${pkg "hyprsome"} movefocus 1"
          "SUPER SHIFT, 2, exec, ${pkg "hyprsome"} movefocus 2"
          "SUPER SHIFT, 3, exec, ${pkg "hyprsome"} movefocus 3"
          "SUPER SHIFT, 4, exec, ${pkg "hyprsome"} movefocus 4"
          "SUPER SHIFT, 5, exec, ${pkg "hyprsome"} movefocus 5"
          "SUPER SHIFT, 6, exec, ${pkg "hyprsome"} movefocus 6"
          "SUPER SHIFT, 7, exec, ${pkg "hyprsome"} movefocus 7"
          "SUPER SHIFT, 8, exec, ${pkg "hyprsome"} movefocus 8"
          "SUPER SHIFT, 9, exec, ${pkg "hyprsome"} movefocus 9"
          "SUPER SHIFT, 0, exec, ${pkg "hyprsome"} movefocus 10"

          "SUPER CTRL, left, workspace, m-1"
          "SUPER CTRL, right, workspace, m+1"
        ]
        ++ map (
          {
            mods,
            key,
            dispatcher,
            params,
          }:
          "${mods}, ${key}, ${dispatcher}, ${params}"
        ) cfg.extraBinds;

      binde = [
        "ALT, left, resizeactive, -40 0"
        "ALT, right, resizeactive, 40 0"
        "ALT, up, resizeactive, 0 -40"
        "ALT, down, resizeactive, 0 40"
      ];

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      exec =
        let
          exec = cmd: "([ $(ps -aux | grep \"${cmd}\" | wc -l) -lt 5 ] && ${cmd})";
        in
        [
          # (exec "waybar")
          (exec "${lib.getExe pkgs.swaybg} -i ${../wallpaper.jpg}")
          (exec (pkgs.polkit_gnome + /libexec/polkit-gnome-authentication-agent-1))
          (scripts.musicfox true)
        ]
        ++ map (cmd: exec cmd) cfg.extraExecs;

      exec-once = [
        "systemctl --user start xdg-desktop-portal-hyprland.service"
        "${pkg' "wl-clipboard" "wl-paste"} --type text --watch cliphist store"
        "${pkg' "wl-clipboard" "wl-paste"} --type image --watch cliphist store"
        "${pkg "wl-clip-persist"} --clipboard regular"
        "hyprctl setcursor Bibata-Modern-Classic 24"
      ] ++ cfg.extraExecOnces;

      env = [
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
        "QT_QPA_PLATFORM, wayland;xcb"
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
        # "LANG, zh_CN.UTF-8"
      ] ++ map ({ name, value }: "${name}, ${value}") cfg.extraEnvs;
    };

    extraConfig = ''
      # Empty submap
      bind = CTRL ALT, escape, submap, empty
      submap = empty
      bind = CTRL ALT, escape, submap, reset
      submap = reset

      # Submap for QEMU
      submap = qemu

      bind = CTRL ALT, escape, submap, reset
      bind = SUPER, 1, exec, ${pkg "hyprsome"} workspace 1
      bind = SUPER, 2, exec, ${pkg "hyprsome"} workspace 2
      bind = SUPER, 3, exec, ${pkg "hyprsome"} workspace 3
      bind = SUPER, 4, exec, ${pkg "hyprsome"} workspace 4
      bind = SUPER, 5, exec, ${pkg "hyprsome"} workspace 5
      bind = SUPER, 6, exec, ${pkg "hyprsome"} workspace 6
      bind = SUPER, 7, exec, ${pkg "hyprsome"} workspace 7
      bind = SUPER, 8, exec, ${pkg "hyprsome"} workspace 8
      bind = SUPER, 9, exec, ${pkg "hyprsome"} workspace 9
      bind = SUPER, 0, exec, ${pkg "hyprsome"} workspace 10

      bind = SUPER SHIFT, 1, exec, ${pkg "hyprsome"} movefocus 1
      bind = SUPER SHIFT, 2, exec, ${pkg "hyprsome"} movefocus 2
      bind = SUPER SHIFT, 3, exec, ${pkg "hyprsome"} movefocus 3
      bind = SUPER SHIFT, 4, exec, ${pkg "hyprsome"} movefocus 4
      bind = SUPER SHIFT, 5, exec, ${pkg "hyprsome"} movefocus 5
      bind = SUPER SHIFT, 6, exec, ${pkg "hyprsome"} movefocus 6
      bind = SUPER SHIFT, 7, exec, ${pkg "hyprsome"} movefocus 7
      bind = SUPER SHIFT, 8, exec, ${pkg "hyprsome"} movefocus 8
      bind = SUPER SHIFT, 9, exec, ${pkg "hyprsome"} movefocus 9
      bind = SUPER SHIFT, 0, exec, ${pkg "hyprsome"} movefocus 10

      bind = SUPER CTRL, left, workspace, m-1
      bind = SUPER CTRL, right, workspace, m+1

      submap = reset
    '';
  };
}
