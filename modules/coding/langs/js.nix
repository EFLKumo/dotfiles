{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomePackagesConfig {
  inherit config pkgs;
  optionPath = [
    "coding"
    "langs"
    "js"
  ];
  packagePaths = [
    [ "nodejs" ]
    [ "pnpm" ]
    [ "bun" ]
    [ "typescript" ]
  ];

  persistHomeDirs = [
    ".bun"
    ".npm"
    ".npm-global"
    ".local/share/pnpm"
  ];

  extraConfig = {
    my.home = {
      home.file.".npmrc".text = ''
        prefix = ''${HOME}/.npm-global
        registry = https://registry.npmmirror.com
      '';
      programs.zsh.initContent = lib.mkAfter ''
        export PATH=$PATH:$HOME/.npm-global/bin
      '';
    };
  };
}
