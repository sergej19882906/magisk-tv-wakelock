# Magisk TV Wakelock

[Русская версия](README.ru.md)

A small Magisk module that keeps supported Android TV devices out of deep sleep by acquiring a legacy kernel wakelock named `tv_wakelock` during Magisk's late-start service stage.

The module does not run a persistent userspace process, modify `/system`, use Zygisk, or make network connections.

## Important warning

Preventing deep sleep can increase standby power consumption and device temperature. Long-term use may increase component wear. Monitor thermals and power usage after installation.

This module prevents kernel suspend only. It does **not** guarantee that the display, HDMI output, CEC devices, network interfaces, applications, or peripherals stay active. The screen may still turn off normally.

## Requirements

- A rooted Android TV device with Magisk.
- Writable legacy wakelock interfaces:
  - `/sys/power/wake_lock`
  - `/sys/power/wake_unlock`
- A kernel and SELinux policy that allow Magisk root to access those interfaces.

Tested on:

- Xiaomi `MiTV-AFKR0`
- Android 14 (SDK 34)
- Magisk 31.1
- SELinux enforcing

Other devices and versions may work, but are not currently verified.

## Installation

1. Download the installable ZIP and `SHA256SUMS` from the latest [GitHub release](https://github.com/sergej19882906/magisk-tv-wakelock/releases/latest).
2. Verify the ZIP checksum.
3. Open Magisk, select **Modules → Install from storage**, and choose the downloaded ZIP.
4. Reboot the device.

Do not install GitHub's automatically generated **Source code** archive. It is not a Magisk module package. Use the ZIP attached to the release.

## Verification

After rebooting, run:

```sh
su -c 'grep -w tv_wakelock /sys/power/wake_lock'
```

Expected output:

```text
tv_wakelock
```

The module also writes one diagnostic log per boot:

```sh
su -c 'cat /data/adb/modules/tv_wakelock/service.log'
```

A successful startup contains:

```text
success: kernel wakelock tv_wakelock acquired
```

## Disable and uninstall

- **Disable:** Disable the module in Magisk and reboot. The already acquired wakelock can remain active until reboot.
- **Uninstall:** Remove the module in Magisk and reboot. `uninstall.sh` also makes a best-effort attempt to release the wakelock immediately.

Emergency manual release on a supported kernel:

```sh
su -c 'echo tv_wakelock > /sys/power/wake_unlock'
```

## Troubleshooting

### `wake_lock is not writable`

The kernel interface is missing, read-only, or blocked by the device SELinux policy. This module intentionally does not install broad SELinux exceptions. Remove or disable the module.

### The wakelock is listed, but the device still loses network or HDMI

A kernel wakelock only blocks deep suspend. Vendor firmware may independently disable networking, HDMI, CEC, applications, or peripherals.

### The device becomes warmer or consumes too much power

Disable or uninstall the module and reboot. This is an expected possible consequence of preventing suspend.

## Build from source

Python 3 is the only build dependency:

```sh
python scripts/build.py
python scripts/verify.py
```

Outputs:

```text
dist/magisk-tv-wakelock-vX.Y.Z.zip
dist/SHA256SUMS
```

The builder uses an explicit file allowlist, fixed timestamps, fixed Unix modes, and no compression so repeated builds are byte-for-byte reproducible.

## License

[MIT](LICENSE) © 2026 sergej19882906
