{
  ...
}:
{
  my = {
    remote-build.enable = true;
    cli = {
      media = {
        cava.enable = true;
        go-musicfox.enable = true;
        mpd.enable = true;
        ffmpeg.enable = true;
      };
      misc.enable = true;
      monitor = {
        btop.enable = true;
      };
      shell = {
        zsh.enable = true;
      };
      util.yazi.enable = true;
    };
    coding = {
      editor = {
        neovim.enable = true;
        vscode.enable = true;
        webstorm.enable = false;
        obsidian.enable = true;
        zed-editor.enable = true;
        notion-app.enable = false;
      };
      langs = {
        c.enable = false;
        go.enable = false;
        js.enable = true;
        python.enable = true;
        rust.enable = true;
        lua.enable = true;
        sqlite.enable = true;
        nix.enable = true;
      };
      tool = {
        reqable.enable = true;
        asar.enable = true;
        package-version-server.enable = true;
        claude-code.enable = true;
      };
      misc.enable = true;
    };
    desktop = {
      browser = {
        chromium.enable = true;
        zen.enable = true;
      };
      gaming = {
        minecraft.enable = true;
        steam.enable = true;
      };
      media = {
        mpv.enable = true;
        shotwell.enable = true;
        thunderbird.enable = true;
        vlc.enable = true;
        spotify.enable = true;
        spotube.enable = true;
        onlyoffice.enable = true;
      };
      notify = {
        dunst.enable = true;
        swaync.enable = true;
      };
      screencast = {
        obs-studio.enable = true;
      };
      terminal = {
        alacritty.enable = false;
        foot.enable = false;
        kitty.enable = true;
        ghostty.enable = false;
        gnome-console.enable = false;
      };
      util = {
        cherry-studio.enable = true;
        xmind.enable = true;
        keyguard.enable = false;
      };
      wm = {
        cage.enable = true;
        niri.enable = true;
      };
      style.enable = true;
      quickshell.enable = true;
    };
    gpg.enable = true;
    i18n.fcitx5.enable = true;
  };
}
