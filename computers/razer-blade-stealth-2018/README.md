# Razer Blade Stealth 2018

## Touchscreen switch

Install the configuration and switch:

```sh
sudo bash ./deploy.sh
```

Deployment removes the old `99-disable-touchscreen.rules` if it matches the
legacy copy in this directory. That rule is retained here for reference only;
do not install it alongside the switch. If the installed rule has been edited,
deployment stops so you can review and remove it manually.

After deployment, disconnect and reconnect the touchscreen once so the desktop
discovers it without the old ignore rule (no reboot or logout needed):

```sh
sudo touchscreen off
sudo touchscreen on
```

Then use:

```sh
touchscreen status
sudo touchscreen off
sudo touchscreen on
sudo touchscreen toggle
```

The script finds the USB device by vendor/product ID `04f3:2379`, rather than a
USB port number that might change. It unbinds/binds that device's USB driver,
not the USB controller, and works independently of X11 or Wayland. `status`
reports the USB binding, not whether the desktop is accepting touch input.

This is a manual switch, not a hardware fix: if touch glitches after wake or
screen blanking, try `off` followed by `on`, or leave it off. It does not perform
a guaranteed electrical power cycle. The state is not persisted across reboot
or device reconnection; the touchscreen will normally start enabled. Disabling
the old ignore rule also means it is no longer disabled automatically at boot.
