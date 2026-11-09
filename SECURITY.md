# Security Policy

## Supported versions

Only the latest GitHub release is supported with security fixes.

## Reporting a vulnerability

Please report security issues privately through [GitHub Security Advisories](https://github.com/sergej19882906/magisk-tv-wakelock/security/advisories/new). Do not include device identifiers, logs containing secrets, private keys, or proprietary firmware images.

Include the module version, Android version, Magisk version, relevant kernel interface permissions, and the minimum steps needed to reproduce the issue.

## Scope

The module runs as root during Magisk's late-start service stage and writes a fixed name to `/sys/power/wake_lock`. It does not use the network, Zygisk, native executables, broad SELinux policy changes, or `/system` overlays.

Power consumption and thermal effects from preventing suspend are expected behavior, not security vulnerabilities, but unexpected privilege escalation, arbitrary command execution, unsafe path handling, or persistent changes after uninstall are in scope.
