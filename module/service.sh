#!/system/bin/sh

MODDIR=${0%/*}
LOG_FILE="$MODDIR/service.log"
WAKELOCK_NAME=tv_wakelock

exec > "$LOG_FILE" 2>&1
echo "start: $(date)"
echo "context: $(id)"

if [ ! -w /sys/power/wake_lock ]; then
  echo "error: /sys/power/wake_lock is not writable"
  exit 1
fi

if ! echo "$WAKELOCK_NAME" > /sys/power/wake_lock; then
  echo "error: failed to acquire kernel wakelock $WAKELOCK_NAME"
  exit 1
fi

if grep -qw "$WAKELOCK_NAME" /sys/power/wake_lock; then
  echo "success: kernel wakelock $WAKELOCK_NAME acquired"
  exit 0
fi

echo "error: kernel wakelock not listed after acquire"
exit 1
