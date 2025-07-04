{
  pkgs,
  username,
  ...
}:
{
  security.pam.loginLimits = [
    {
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "524288";
    }
  ];

  boot.kernelParams = [
    "usbcore.autosuspend=-1" # Avoid usb autosuspend (for usb bluetooth adapter)
    "fsck.mode=skip"
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
    grub.enable = false;
    timeout = 0;
  };

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  systemd.services.nix-daemon = {
    environment.TMPDIR = "/var/cache/nix";
    serviceConfig.CacheDirectory = "nix";
  };
  environment.variables.NIX_REMOTE = "daemon";

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = false;
    alsa.support32Bit = false;
    pulse.enable = false;
    audio.enable = false;
  };
  services.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
    extraConfig = ''
      load-module module-switch-on-connect
      unload-module module-suspend-on-idle
    '';
  };
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General.Enable = "Source,Sink,Media,Socket";
    };
  };
  users.extraUsers.${username}.extraGroups = [ "audio" ];

  fonts = {
    enableDefaultPackages = false;
    fontDir.enable = true;

    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji

      jetbrains-mono

      nerd-fonts.symbols-only
    ];

    fontconfig.defaultFonts = {
      serif = [
        "Noto Serif CJK SC"
        "Noto Serif"
        "Symbols Nerd Font"
        "Noto Color Emoji"
      ];
      sansSerif = [
        "Noto Sans CJK SC"
        "Noto Sans"
        "Symbols Nerd Font"
        "Noto Color Emoji"
      ];
      monospace = [
        "JetBrains Mono"
        "Noto Sans Mono CJK SC"
        "Symbols Nerd Font Mono"
        "Noto Color Emoji"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  services.printing.enable = true;

  services.keyd = {
    enable = true;
    keyboards.default.settings = {
      main = {
        capslock = "overload(control, esc)";
      };
    };
  };

  # services.gvfs.enable = true;
  #
  # virtualisation.waydroid.enable = true;
  #
  # programs.wireshark.enable = true;
  # programs.wireshark.package = pkgs.wireshark;
  # users.users.${username}.extraGroups = [ "wireshark" ];
  #
  # services.sunshine = {
  #   enable = true;
  #   autoStart = true;
  #   capSysAdmin = true;
  #   applications.apps = [
  #     {
  #       name = "Desktop";
  #       image-path = "desktop.png";
  #     }
  #   ];
  # };
  services.openssh = {
    enable = true;
    settings = {
      # Forbid root login through SSH.
      PermitRootLogin = null;
      PasswordAuthentication = true;
    };
  };
}
