{
  config,
  lib,
  pkgs,
  username,
  userFullName,
  userProtectedEmail,
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
      programs.git = {
        enable = true;
        userName = "${userFullName}";
        userEmail = "${userProtectedEmail}";

        signing = {
          format = "ssh";
          key = "/persistent/home/${username}/.ssh/github_ed25519.pub";
          signByDefault = true;
        };

        extraConfig = {
          push.autoSetupRemote = true;
          init.defaultBranch = "main";
        };
      };

      home.packages = with pkgs; [
        lsd
        fd
        neofetch
        fzf
        bat
        ripgrep

        aria2
        socat

        trash-cli

        cht-sh

        dooit

        # translate-shell
      ];
    };
  };
}
