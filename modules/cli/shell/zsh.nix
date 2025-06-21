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
    my.home =
      let
        stateHome = config.my.home.xdg.stateHome;
      in
      {
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
          ];
          dotDir = ".config/zsh";
          history = {
            path = "${stateHome}/zsh_history";
            ignorePatterns = [
              "la"
            ];
          };
          initContent = ''

          '';
          sessionVariables = {
            _ZL_DATA = "${stateHome}/zlua";
            _FZF_HISTORY = "${stateHome}/fzf_history";
          };
          shellAliases = {
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
            "extract"
            "git"
            "sudo"
            "z"
          ];
          custom = "$HOME/.config/oh-my-zsh-custom";
          # theme = "kumo";
          theme = "bira";
        };
        xdg.configFile."oh-my-zsh-custom/themes/kumo.zsh-theme".source = ./kumo.zsh-theme;
      };
  };
}
