{
  config,
  lib,
  pkgs,
  userFullName,
  userProtectedEmail,
  ...
}:
lib.my.makeHomeProgramsConfig {
  inherit config;
  optionPath = [
    "cli"
    "vcs"
    "jj"
  ];

  programs = {
    jujutsu = {
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

    starship = {
      settings = lib.recursiveUpdate (with builtins; fromTOML (readFile ./starship-preset.toml)) {
        add_newline = false;
        custom = {
          jj = {
            ignore_timeout = true;
            description = "The current jj status";
            when = "jj root";
            symbol = " ";
            command = ''
              jj log --revisions @ --no-graph --ignore-working-copy --color always --limit 1 --template '
                separate(" ",
                  change_id.shortest(4),
                  bookmarks,
                  "|",
                  concat(
                    if(conflict, "💥"),
                    if(divergent, "🚧"),
                    if(hidden, "👻"),
                    if(immutable, "🔒"),
                  ),
                  raw_escape_sequence("\x1b[1;32m") ++ if(empty, "(empty)"),
                  raw_escape_sequence("\x1b[1;32m") ++ coalesce(
                    truncate_end(29, description.first_line(), "…"),
                    "(no description set)",
                  ) ++ raw_escape_sequence("\x1b[0m"),
                )
              '
            '';
          };
          git_branch = {
            when = true;
            command = "jj root >/dev/null 2>&1 || starship module git_branch";
            description = "Only show git_branch if we're not in a jj repo";
          };
          git_status = {
            when = true;
            command = "jj root >/dev/null 2>&1 || starship module git_status";
            description = "Only show git_status if we're not in a jj repo";
          };
        };
        git_state.disabled = true;
        git_commit.disabled = true;
        git_metrics.disabled = true;
        git_branch.disabled = true;
        git_status.disabled = true;
        nix_shell.disabled = true;
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
