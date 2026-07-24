# Disko configuration for srv-01 (Proxmox VM / Bare-Metal)
#
# Usage:
# - Adjust `device = "/dev/sda";` if Proxmox uses VirtIO disks (`/dev/vda`) or NVMe (`/dev/nvme0n1`).
# - Btrfs subvolumes allow clean separation of root, home, nix store, and server data (/var/lib).
{
  disko.devices = {
    disk = {
      main = {
        # Modify this to match your disk device (e.g. /dev/vda for VirtIO SCSI, /dev/sda for SCSI, /dev/nvme0n1 for NVMe)
        device = "/dev/sda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Force overwrite existing partitions
                subvolumes = {
                  # Subvolume for root filesystem
                  "@" = {
                    mountpoint = "/";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  # Subvolume for user home directories
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  # Subvolume for Nix store
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  # Subvolume for persistent server application data (Docker, Podman, K3s, DBs)
                  "@storage" = {
                    mountpoint = "/var/lib";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  # Subvolume for system logs
                  "@log" = {
                    mountpoint = "/var/log";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                };
              };
            };
          };
        };
      };
      # Optional: Uncomment and configure if adding a second disk in Proxmox (e.g. /dev/sdb)
      # data = {
      #   device = "/dev/sdb";
      #   type = "disk";
      #   content = {
      #     type = "gpt";
      #     partitions = {
      #       storage = {
      #         size = "100%";
      #         content = {
      #           type = "filesystem";
      #           format = "ext4";
      #           mountpoint = "/mnt/data";
      #         };
      #       };
      #     };
      #   };
      # };
    };
  };
}
