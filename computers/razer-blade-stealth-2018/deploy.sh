#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if (( EUID != 0 )); then
  echo "Run this script with sudo: sudo $0" >&2
  exit 1
fi

install -D -m 0644 "$SCRIPT_DIR/61-razer-touchpad.hwdb" \
  /etc/udev/hwdb.d/61-razer-touchpad.hwdb
install -D -m 0644 "$SCRIPT_DIR/99-disable-touchscreen.rules" \
  /etc/udev/rules.d/99-disable-touchscreen.rules

if command -v systemd-hwdb >/dev/null 2>&1; then
  systemd-hwdb update
elif command -v udevadm >/dev/null 2>&1; then
  udevadm hwdb --update
else
  echo "Neither systemd-hwdb nor udevadm was found; cannot rebuild the hardware database." >&2
  exit 1
fi

udevadm control --reload
echo "Installed udev configuration. Reboot for the touchpad and touchscreen changes to take effect."
