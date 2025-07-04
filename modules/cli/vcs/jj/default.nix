{
  config,
  lib,
  pkgs,
  userFullName,
  userProtectedEmail,
  ...
}:
lib.my.makeHomeProgramConfig {
  inherit config;
  programName = "jujutsu";
  optionPath = [
    "cli"
    "vcs"
    "jj"
  ];
  programConfig = {
    settings = {
      user = {
        name = "${userFullName}";
        email = "${userProtectedEmail}";
      };
      ui = {
        default-command = "status";
      };
    };
  };

  extraConfig = {
    my.home = {
      home.packages = [ pkgs.lazyjj ];

      /*
        programs.zsh.plugins = [
        {
          name = "zsh-jj";
          src = pkgs.fetchFromGitHub {
            owner = "rkh";
            repo = "zsh-jj";
            rev = "b6453d6ff5d233d472e5088d066c6469eb05c71b";
            hash = "sha256-GDHTp53uHAcyVG+YI3Q7PI8K8M3d3i2+C52zxnKbSmw=";
          };
        }
        ];
      */
    };
  };
}
