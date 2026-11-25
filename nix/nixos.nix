{ ... }:
{
  # Needed for the control center's Bluetooth toggle (services/Bluetooth.qml):
  # provides bluetoothd and the bluetoothctl binary it polls.
  hardware.bluetooth.enable = true;
}
