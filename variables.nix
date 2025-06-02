rec {
  username = "efl";
  userFullName = "EFLKumo";
  userDesc = userFullName;
  userProtectedEmail = "96906415+EFLKumo@users.noreply.github.com";
  arch = {
    aarch64 = {
      linux = "aarch64-linux";
      darwin = "aarch64-darwin";
    };
    i686 = {
      linux = "i686-linux";
    };
    x86_64 = {
      linux = "x86_64-linux";
      darwin = "x86_64-darwin";
    };
  };
  hosts =
    with arch;
    let
      hostprefix = "efl-nix";
    in
    [
      {
        hostname = hostprefix;
        system = x86_64.linux;
      }
    ];
}
