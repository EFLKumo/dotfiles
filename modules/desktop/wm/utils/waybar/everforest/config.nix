{
  margin-top = 0;
  margin-left = 120;
  margin-bottom = 0;
  margin-right = 120;
  height = 0;
  layer = "top";
  position = "top";
  mod = "dock";
  spacing = 15;
  passthrough = true;
  exclusive = true;
  gtk-layer-shell = true;

  modules-left = [
    "custom/launcher"
    "clock"
    "clock#date"
  ];
  modules-center = [ "niri/workspaces" ];
  modules-right = [
    "pulseaudio"
    "network"
    "battery"
    "custom/powermenu"
  ];

  "wlr/workspaces" = {
    disable-scroll = true;
    all-outputs = true;
    "on-click" = "activate";
    "on-scroll-up" = "hyprctl dispatch workspace e+1";
    "on-scroll-down" = "hyprctl dispatch workspace e-1";
    persistent_workspaces = {
      "1" = [ ];
      "2" = [ ];
      "3" = [ ];
      "4" = [ ];
      "5" = [ ];
      "6" = [ ];
      "7" = [ ];
      "8" = [ ];
      "9" = [ ];
      "10" = [ ];
    };
  };

  "niri/workspaces" = {
    format = "{value}";
  };

  "custom/launcher" = {
    interval = "once";
    format = "󰣇";
    "on-click" =
      "pkill wofi || wofi --show drun --term=kitty --width=20% --height=50% --columns 1 -I -s ~/.config/wofi/themes/everforest-light.css -o $MAIN_DISPLAY";
    tooltip = false;
  };

  backlight = {
    device = "nvidia_0";
    "max-length" = "4";
    format = "{icon}";
    "tooltip-format" = "{percent}%";
    "format-icons" = [
      ""
      ""
      ""
      ""
      ""
      ""
      ""
    ];
    "on-click" = "";
    "on-scroll-up" = "brightnessctl set 10%-";
    "on-scroll-down" = "brightnessctl set +10%";
  };

  memory = {
    interval = 30;
    format = "  {}%";
    "format-alt" = " {used:0.1f}G";
    "max-length" = 10;
  };

  "custom/dunst" = {
    exec = "~/.config/waybar/scripts/dunst.sh";
    "on-click" = "dunstctl set-paused toggle";
    "restart-interval" = 1;
    tooltip = false;
  };

  pulseaudio = {
    format = "{icon} {volume}%";
    "format-bluetooth" = "{icon}  {volume}%";
    "format-bluetooth-muted" = "婢  muted";
    "format-muted" = "婢 muted";
    "format-icons" = {
      headphone = "";
      "hands-free" = "";
      headset = "";
      phone = "";
      portable = "";
      car = "";
      default = [
        ""
        ""
        ""
      ];
    };
    "on-click-right" = "pavucontrol";
    "on-click" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
  };

  network = {
    "format-wifi" = " {signalStrength}%";
    "format-ethernet" = " {signalStrength}%";
    "format-disconnected" = "󰤭";
    "on-click" = "sh ~/.config/wofi/scripts/wifimenu.sh";
  };

  battery = {
    bat = "BAT0";
    adapter = "ADP0";
    interval = 60;
    states = {
      warning = 30;
      critical = 15;
    };
    "max-length" = 10;
    format = "{icon} {capacity}%";
    "format-warning" = "{icon} {capacity}%";
    "format-critical" = "{icon} {capacity}%";
    "format-charging" = " {capacity}%";
    "format-plugged" = " {capacity}%";
    "format-alt" = "{icon} {capacity}%";
    "format-full" = " 100%";
    "format-icons" = [
      ""
      ""
      ""
      ""
      ""
      ""
      ""
      ""
      ""
      ""
    ];
  };

  clock = {
    format = " {:%H:%M}";
  };

  "clock#date" = {
    format = " {:%A, %B %d, %Y}";
  };

  "custom/powermenu" = {
    format = "";
    "on-click" =
      "pkill wofi || sh .config/wofi/scripts/powermenu.sh 'everforest-light' '--height=17% -o $MAIN_DISPLAY'";
    tooltip = false;
  };
}
