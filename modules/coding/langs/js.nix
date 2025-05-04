{
  config,
  lib,
  pkgs,
  ...
}:
lib.my.makeSwitch {
  inherit config;
  optionName = "js";
  optionPath = [
    "coding"
    "langs"
    "js"
  ];
  config' = {
    my.home = {
      home.packages = with pkgs; [
        nodejs
        # nodePackages.npm
        pnpm
        typescript
      ];
      home.file.".npmrc".text = ''
        prefix = ''${HOME}/.npm-global
        registry = https://registry.npmmirror.com
      '';
    };
    my.persist.homeDirs = [
      ".npm"
      ".npm-global"
      ".local/share/pnpm"

      # @anthropic-ai/claude-code
      ".claude"
      # @openai/codex
      ".codex"
    ];
  };
}
