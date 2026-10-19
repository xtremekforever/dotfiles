#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if (( EUID != 0 )); then
  echo "Run this script with sudo: sudo $0" >&2
  exit 1
fi

# The old ignore rule prevents the desktop from seeing a rebound touchscreen.
# Only remove the known version; do not overwrite locally customized rules.
OLD_RULE=/etc/udev/rules.d/99-disable-touchscreen.rules
if [[ -e "$OLD_RULE" || -L "$OLD_RULE" ]]; then
  if cmp -s -- "$SCRIPT_DIR/99-disable-touchscreen.rules" "$OLD_RULE"; then
    rm -- "$OLD_RULE"
  else
    echo "Review and remove $OLD_RULE manually; it differs from the legacy rule in this directory." >&2
    exit 1
  fi
fi

install -D -m 0644 "$SCRIPT_DIR/61-razer-touchpad.hwdb" \
  /etc/udev/hwdb.d/61-razer-touchpad.hwdb
install -D -m 0755 "$SCRIPT_DIR/touchscreen" /usr/local/bin/touchscreen

if command -v systemd-hwdb >/dev/null 2>&1; then
  systemd-hwdb update
elif command -v udevadm >/dev/null 2>&1; then
  udevadm hwdb --update
else
  echo "Neither systemd-hwdb nor udevadm was found; cannot rebuild the hardware database." >&2
  exit 1
fi

udevadm control --reload
echo "Installed touchpad configuration and touchscreen switch."
echo "Reboot for touchpad changes. For the touchscreen, run:"
echo "  sudo touchscreen off"
echo "  sudo touchscreen on"
