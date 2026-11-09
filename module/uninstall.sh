#!/system/bin/sh

WAKELOCK_NAME=tv_wakelock

if [ -w /sys/power/wake_unlock ]; then
  echo "$WAKELOCK_NAME" > /sys/power/wake_unlock 2>/dev/null || true
fi
