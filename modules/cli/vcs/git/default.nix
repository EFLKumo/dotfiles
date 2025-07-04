{
  config,
  lib,
  username,
  userFullName,
  userProtectedEmail,
  ...
}:
lib.my.makeHomeProgramsConfig {
  inherit config;
  optionPath = [
    "cli"
    "vcs"
    "git"
  ];

  programs = {
    git = {
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

    lazygit = { };
  };
}
