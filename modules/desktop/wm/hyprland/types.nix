lib: {
  monitor = lib.types.submodule {
    options = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "";
      };
      resolution = lib.mkOption {
        type = lib.types.str;
        default = "preffered";
      };
      position = lib.mkOption {
        type = lib.types.str;
        default = "auto";
      };
      scale = lib.mkOption {
        type = lib.types.str;
        default = "1";
      };
      disable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      mirror = lib.mkOption {
        type = with lib.types; nullOr str;
        default = null;
      };
      "10bit" = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      vrr = lib.mkOption {
        type = with lib.types; nullOr (enum (lib.range 0 2));
        default = null;
      };
      rotate = lib.mkOption {
        type = with lib.types; nullOr (enum (lib.range 0 7));
        default = null;
      };
    };
  };
  env = lib.types.submodule {
    options = {
      name = lib.mkOption {
        type = lib.types.str;
      };
      value = lib.mkOption {
        type = lib.types.str;
      };
    };
  };
  bind = lib.types.submodule {
    options = {
      mods = lib.mkOption {
        type = lib.types.str;
      };
      key = lib.mkOption {
        type = lib.types.str;
      };
      dispatcher = lib.mkOption {
        type = lib.types.str;
      };
      params = lib.mkOption {
        type = lib.types.str;
      };
    };
  };
}
