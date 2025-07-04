{ lib }:

{
  makeSwitch =
    {
      default ? false,
      config,
      optionPath,
      optionName,
      config',
    }:
    let
      cfg = lib.getAttrFromPath optionPath config.my;
    in
    {
      options.my = lib.setAttrByPath optionPath {
        enable = (lib.mkEnableOption optionName) // {
          inherit default;
        };
      };

      config = lib.mkIf cfg.enable config';
    };

  makeHomePackageConfig =
    {
      config,
      pkgs,
      packageName ? builtins.elemAt packagePath (builtins.length packagePath - 1),
      packagePath,
      optionPath,
      extraConfig ? { },
      persistHomeDirs ? [ ],
      persistHomeFiles ? [ ],
    }:
    let
      packages = [ (lib.getAttrFromPath packagePath pkgs) ];
    in
    lib.my.makeSwitch {
      inherit config optionPath;
      optionName = packageName;
      config' = lib.mkMerge [
        {
          my.home.home.packages = packages;
          my.persist.homeDirs = persistHomeDirs;
          my.persist.homeFiles = persistHomeFiles;
        }
        extraConfig
      ];
    };

  makeHomePackagesConfig =
    {
      config,
      pkgs,
      packagePaths,
      optionPath,
      extraConfig ? { },
      persistHomeDirs ? [ ],
      persistHomeFiles ? [ ],
    }:
    let
      packages = map (path: lib.getAttrFromPath path pkgs) packagePaths;
      packageNames = map (path: builtins.elemAt path (builtins.length path - 1)) packagePaths;
      optionName = "Packages: " + (lib.concatStringsSep ", " packageNames);
    in
    lib.my.makeSwitch {
      inherit config optionPath;
      optionName = optionName;

      config' = lib.mkMerge [
        {
          my.home.home.packages = packages;
          my.persist.homeDirs = persistHomeDirs;
          my.persist.homeFiles = persistHomeFiles;
        }
        extraConfig
      ];
    };

  makeHomeProgramConfig =
    {
      config,
      programName ? builtins.elemAt optionPath (builtins.length optionPath - 1),
      optionPath,
      programConfig ? { },
      configFiles ? { },
      configDirs ? { },
      extraConfig ? { },
      persistHomeDirs ? [ ],
      persistHomeFiles ? [ ],
    }:
    let
      xdgConfigFiles = lib.mapAttrs (name: source: { inherit source; }) configFiles;
      xdgConfigDirs = lib.mapAttrs (name: source: {
        inherit source;
        recursive = true;
      }) configDirs;
    in
    lib.my.makeSwitch {
      inherit config optionPath;
      optionName = programName;

      config' = lib.mkMerge [
        {
          my.home.programs = lib.setAttrByPath [ programName ] (programConfig // { enable = true; });
          my.persist.homeDirs = persistHomeDirs;
          my.persist.homeFiles = persistHomeFiles;
          my.home.xdg.configFile = xdgConfigFiles // xdgConfigDirs;
        }
        extraConfig
      ];
    };

  makeHomeProgramsConfig =
    {
      config,
      optionPath,
      programs,
      configFiles ? { },
      configDirs ? { },
      extraConfig ? { },
      persistHomeDirs ? [ ],
      persistHomeFiles ? [ ],
    }:
    let
      programConfigs = lib.mapAttrsToList (programName: programConfig: {
        my.home.programs = lib.setAttrByPath [ programName ] (programConfig // { enable = true; });
      }) programs;
      programNames = lib.attrNames programs;
      optionName = "Programs: " + (lib.concatStringsSep ", " programNames);

      xdgConfigFiles = lib.mapAttrs (name: source: { inherit source; }) configFiles;
      xdgConfigDirs = lib.mapAttrs (name: source: {
        inherit source;
        recursive = true;
      }) configDirs;
    in
    lib.my.makeSwitch {
      inherit config optionPath;
      optionName = optionName;

      config' = lib.mkMerge (
        [
          {
            my.persist.homeDirs = persistHomeDirs;
            my.persist.homeFiles = persistHomeFiles;
            my.home.xdg.configFile = xdgConfigFiles // xdgConfigDirs;
          }
          extraConfig
        ]
        ++ programConfigs
      );
    };

  makeNixosPackageConfig =
    {
      config,
      pkgs,
      packageName,
      packagePath,
      optionPath,
      extraConfig ? { },
    }:
    lib.my.makeSwitch {
      inherit config optionPath;
      optionName = packageName;
      config' = lib.mkMerge [
        {
          environment.systemPackages = [ (lib.getAttrFromPath packagePath pkgs) ];
        }
        extraConfig
      ];
    };

  makeNixosProgramConfig =
    {
      config,
      programName,
      optionPath,
      extraConfig ? { },
    }:
    lib.my.makeSwitch {
      inherit config optionPath;
      optionName = programName;

      config' = lib.mkMerge [
        {
          programs = lib.setAttrByPath [ programName "enable" ] true;
        }
        extraConfig
      ];
    };
}
