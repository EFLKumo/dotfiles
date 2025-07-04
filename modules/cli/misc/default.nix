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

    programs.zsh.enable = true;
    programs.dconf.enable = true;

    my.home = {
      programs.home-manager.enable = true;

      home.packages = with pkgs; [
        lsd
        fd
        neofetch
        fzf
        bat
        ripgrep

        aria2
        socat

        cht-sh

        # translate-shell
      ];
    };
  };
}
