# with-fi
This script is meant for Raspberry Pi's that are running RaspAp.

If you don't have a wifi-dongle or ethernet cord to give your device internet connection, but you are able to SSH into your device through RaspAp and you need to run a command on the RaspAp-Enabled device with wifi, then this script is for you!

### Prerequisites
1) RaspAp installed on the target device (Preferably a Rasberry Pi)
2) Able to SSH into the RaspAp-Enabled device
3) Running a debian-based distribution of linux (Ubuntu, Mint, PiOs)

Commonly I create a directory in `/etc/raspap/` named `misc` and i move the script files there. Will probably automate this process in the future

## How it Works
It simply:
`Turns off RaspAp -> Connects to a nearby Wi-fi -> Runs your command -> Logs output of command -> Turns on RaspAp so the client is allowed to reconnect`

Feel free to make any adjustments or improvements to this script!
