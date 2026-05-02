# Talos - understairs cluster

## Nodes

| Node    | Role          | Hardware         | IP             |
| ------- | ------------- | ---------------- | -------------- |
| pi1     | control-plane | Raspberry Pi 4B  | 192.168.20.110 |
| minipc1 | worker        | Mini PC (x86_64) | 192.168.20.116 |

## Image Factory

Schematics are posted to the Image Factory API to obtain a content-addressable ID:

```bash
curl -X POST --data-binary @schematic.yaml https://factory.talos.dev/schematics
```

### Pi 4 schematic

ID: `3528f6192c4bd9dbf9f310f1141cbf2e7b6114ce6c04c67f2ba73e9eb7727dba`

```yaml
overlay:
    image: siderolabs/sbc-raspberrypi
    name: rpi_generic
    options:
        configTxt: |
            gpu_mem=32
            kernel=u-boot.bin
            arm_64bit=1
            arm_boost=1
            dtoverlay=disable-bt
            dtoverlay=disable-wifi
            dtoverlay=gpio-fan,gpiopin=14
# customization:
#     systemExtensions:
#         officialExtensions:
#             - siderolabs/btrfs
#             - siderolabs/fuse3
#             - siderolabs/glibc
#             - siderolabs/gvisor
#             - siderolabs/iscsi-tools
#             - siderolabs/lldpd
#             - siderolabs/util-linux-tools
```
