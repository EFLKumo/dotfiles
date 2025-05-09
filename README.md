# dotfiles

The NixOS configuration I used.

## Usage
If you do not have NixOS installed, please navigate to the Install NixOS section below.  

1. Harware: modify `config/hosts/efl-nix/hardware.nix`
2. Modify `variables.nix`
3. SOPS: configure sops in `modules/sops.nix`, add your age and ssh keys here
4. Network: place mihomo.yaml under `secrets/origin`, modify `secrets/origin/dae.dae` as needed
5. User login: use `mkpasswd` to hash your password and write it to `secrets/origin/efl-nix-hashed-password.txt`
6. Run `make encrypt` to encrypt all `secrets/origin/` files into `secrets/`
7. `make`

This configuration employs NetworkManager so if you're not using WLAN, please disable it.

## Install NixOS

**None of the commands can be copied and run directly, so make sure you know what you're doing!**

Firstly partition the disk:

```shell
lsblk

su
cfdisk /dev/... # 1. 500MB EFI System 2. Rest space
mkfs.fat -F32 /dev/..EFI..
mkfs.btrfs /dev/..main..

mount /dev/..main.. /mnt
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/nix
btrfs subvolume create /mnt/persistent
umount /mnt

mount /dev/..main.. /mnt -o subvol=root,compress=zstd

mkdir -p /mnt/{boot,nix,persistent}
mount /dev/..main.. /mnt/nix -o subvol=nix,compress=zstd,noatime
mount /dev/..main.. /mnt/persistent -o subvol=persistent,compress=zstd
mount /dev/..efi.. /mnt/boot
```

### Basic Configuration

```shell
sudo nixos-generate-config --show-hardware-config --root /mnt > hardware.nix
```

Look at the `fileSystems` section of `hardware.nix` and copy it to `remote/hardware.nix`; keep only `/` `/nix` `/persistent` `/boot` and remove other partitions.

Add `i915.enable_psr=0` and `i8042.dumbkbd` to `remote/hardware.nix.boot.kernelParams` as needed.

Add swap by

```shell
boot = ...
swapDevices = [
  {
    device = "/var/lib/swapfile";
    size = 8192;
  }
];
```

### Build

```shell
su
mkdir -p /mnt/persistent/etc
uuidgen | tr -d '-' > /persistent/etc/machine-id
```

```shell
nixos-rebuild switch --flake . --use-remote-sudo
```

*During the build phase, China mainland users may need international network access.*
```shell
nix shell nixpkgs#mihomo --substituters "https://mirrors.sjtug.sjtu.edu.cn/nix-channels/store,https://cache.nixos.org"
```
Then run mihomo with your config and export proxy ports:
```shell
export http_proxy=http://127.0.0.1:7890
export https_proxy=http://127.0.0.1:7890
```