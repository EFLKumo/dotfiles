{
  ...
}:
{
  my = {
    nix-ld.enable = true;
    remote-build.enable = true;
    network-proxy.enable = true;
    cli = {
      media = {
        baidupcs-go.enable = true;
        cava.enable = true;
        go-musicfox.enable = true;
        mpd.enable = true;
        ffmpeg.enable = true;
      };
      misc.enable = true;
      monitor = {
        btop.enable = true;
        dysk.enable = true;
      };
      shell = {
        zsh.enable = true;
        tmux.enable = true;
      };
      vcs = {
        git.enable = true;
        jj.enable = true;
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
        qml.enable = false;
      };
      tools = {
        reqable.enable = true;
        asar.enable = true;
        package-version-server.enable = true;
        claude-code.enable = false;
        gemini-cli.enable = true;
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
        thunderbird.enable = false;
        vlc.enable = true;
        spotify.enable = false;
        spotube.enable = false;
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
        xmind.enable = false;
        keyguard.enable = false;
      };
      wm = {
        cage.enable = true;
        niri.enable = true;
      };
      style.enable = true;
      quickshell.enable = true;
      wine.enable = true;
    };
    gpg.enable = true;
    i18n.fcitx5.enable = true;
  };
}
