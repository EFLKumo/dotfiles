{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  btrfs = "/dev/disk/by-uuid/f25c9de2-86fd-41e1-9f1f-90dff4ee5287";
in
{
  boot = {
    initrd = {
      kernelModules = [ ];
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "usb_storage"
        "sd_mod"
      ];
      verbose = false;
    };

    kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_zen;
    kernelModules = [ "kvm-intel" ];

    tmp.useTmpfs = true;
    kernel.sysctl = {
      "fs.file-max" = 9223372036854775807;
    };
  };

  fileSystems."/" = {
    device = btrfs;
    fsType = "btrfs";
    options = [ "subvol=root" ];
  };

  fileSystems."/nix" = {
    device = btrfs;
    fsType = "btrfs";
    options = [ "subvol=nix" ];
  };

  fileSystems."/persistent" = {
    device = btrfs;
    fsType = "btrfs";
    options = [ "subvol=persistent" ];
    neededForBoot = true;
  };

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount ${btrfs} /btrfs_tmp
    mkdir -p /btrfs_tmp/old_roots
    if [[ -e /btrfs_tmp/root ]]; then
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +14); do
        delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
  '';

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/9F93-2095";
    fsType = "vfat";
    options = [
      "uid=0"
      "gid=0"
      "fmask=0077"
      "dmask=0077"
    ];
  };

  networking.useDHCP = lib.mkDefault false;

  hardware.enableRedistributableFirmware = lib.mkDefault true;
  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;

  nixpkgs.hostPlatform = lib.mkForce "x86_64-linux";
}
