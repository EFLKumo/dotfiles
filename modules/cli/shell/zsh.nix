{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeSwitch {
  inherit config;
  default = true;
  optionName = "default zsh settings";
  optionPath = [
    "cli"
    "shell"
    "zsh"
  ];
  config' = {
    my.persist.homeDirs = [ ".local/share/zoxide" ];
    my.home =
      let
        stateHome = config.my.home.xdg.stateHome;
      in
      {
        home.packages = with pkgs; [
          fzf
          zoxide
        ];
        programs.zsh = {
          enable = true;
          plugins = [
            {
              name = "zsh-autosuggestions";
              src = pkgs.fetchFromGitHub {
                owner = "zsh-users";
                repo = "zsh-autosuggestions";
                rev = "0e810e5afa27acbd074398eefbe28d13005dbc15";
                hash = "sha256-85aw9OM2pQPsWklXjuNOzp9El1MsNb+cIiZQVHUzBnk=";
              };
            }
            {
              name = "zsh-syntax-highlighting";
              src = pkgs.fetchFromGitHub {
                owner = "zsh-users";
                repo = "zsh-syntax-highlighting";
                rev = "5eb677bb0fa9a3e60f0eff031dc13926e093df92";
                hash = "sha256-KRsQEDRsJdF7LGOMTZuqfbW6xdV5S38wlgdcCM98Y/Q=";
              };
            }
            {
              name = "fzf-tab";
              src = pkgs.fetchFromGitHub {
                owner = "Aloxaf";
                repo = "fzf-tab";
                rev = "2abe1f2f1cbcb3d3c6b879d849d683de5688111f";
                hash = "sha256-zc9Sc1WQIbJ132hw73oiS1ExvxCRHagi6vMkCLd4ZhI=";
              };
            }
          ];
          dotDir = "${config.my.home.xdg.configHome}/zsh";
          history = {
            path = "${stateHome}/zsh_history";
            ignorePatterns = [
              "la"
            ];
          };
          initContent = lib.mkAfter ''
            eval "$(zoxide init zsh)"
          '';
          shellAliases = {
            x = "extract";
            ls = "lsd";
            svim = "sudoedit";
            nf = "neofetch";
            tmux = "tmux -T RGB,focus,overline,mouse,clipboard,usstyle";
            pastart = "pasuspender true";
          };
        };

        programs.zsh.oh-my-zsh = {
          enable = true;
          plugins = [
            "branch"
            "colorize"
            "dotenv"
            "extract"
            "git"
            "git-extras"
            "sudo"
          ];
          theme = "bira";
        };
        # xdg.configFile."oh-my-zsh-custom/themes/kumo.zsh-theme".source = ./kumo.zsh-theme;

        programs.starship = {
          enable = true;
          settings = {
            directory = {
              truncate_to_repo = true;
              truncation_length = 1;
            };
            battery.display = [
              {
                threshold = 30;
                style = "bold yellow";
              }
              {
                threshold = 20;
                style = "bold red";
              }
            ];
          };
        };
      };
  };
}
