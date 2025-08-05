{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeHomeProgramConfig {
  inherit config;
  programName = "neovim";
  optionPath = [
    "coding"
    "editor"
    "neovim"
  ];

  persistHomeDirs = [ ".local/share/nvim" ];

  programConfig = {
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraPackages = with pkgs; [
      gcc
      gnumake

      pyright

      clang-tools

      rust-analyzer
      pest-ide-tools

      nixd

      gotools
      gopls

      stylua
      lua-language-server

      nodePackages.typescript-language-server
      vue-language-server
      typescript
      nodejs

      ripgrep
    ];
  };

  configFiles = {
    "nvim/init.lua" = ./nvim/init.lua;
  };
  configDirs = {
    "nvim/lua" = ./nvim/lua;
  };
}
