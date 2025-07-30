{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeSwitch {
  inherit config;
  default = true;
  optionName = "misc command line tools";
  optionPath = [
    "cli"
    "misc"
  ];
  config' = {
    environment.systemPackages = with pkgs; [
      vim
      wget
      git

      file
      gnused
      gnutar

      zip
      unzip
      xz
      p7zip
      unrar-free

      pciutils
      usbutils

      lsof

      nmap
      traceroute
      tcping-go
      dnsutils

      killall
    ];

    programs.dconf.enable = true;

    my.home = {
      programs.home-manager.enable = true;
      programs.tealdeer = {
        enable = true;
        enableAutoUpdates = true;
        settings.updates.auto_update = true;
      };

      programs.television = {
        enable = true;
        enableZshIntegration = true;
      };

      home.packages = with pkgs; [
        lsd
        fd
        fastfetch
        fzf
        bat
        ripgrep

        aria2
        socat

        # translate-shell
      ];
    };
  };
}
