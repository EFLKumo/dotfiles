{
  config,
  lib,
  username,
  userFullName,
  userProtectedEmail,
  ...
}:
lib.my.makeHomeProgramConfig {
  inherit config;
  programName = "git";
  optionPath = [
    "cli"
    "vcs"
    "git"
  ];

  extraConfig = {
    my.home = {
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
      programs.lazygit = {
        enable = true;
      };
    };
  };
}
