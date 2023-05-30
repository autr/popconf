# VERY IMPORTANT

General notes on Debian Buster installation on flea market PCs.

## BULLSEYE / BUSTER (Wayland etc)

Disable Wayland

```

sudo nano /etc/gdm3/custom.conf
WaylandEnable=false
```

https://gist.github.com/oprizal/998635a2ff5cbecb0519455c12b2994f

## Synology Recovery

https://kb.synology.com/en-my/DSM/tutorial/How_can_I_recover_data_from_my_DiskStation_using_a_PC

## Snap Store

Everything installed correctly, but Launcher apps and PATH do not work:

* Desktop files are in /var/lib/snapd/desktop/applications/ rather than /usr/share/applications
* Binaries are in /snap/bin rather than /usr/bin

Solution was:

```
# inside .zshrc or .profile:
emulate sh -c 'source /etc/profile.d/apps-bin-path.sh'

# copy desktop files (do this after each install :( ):
sudo cp /var/lib/snapd/desktop/applications/* /usr/share/applications

```

## NVIDIA Installation

* on Ubuntu, you have `ubuntu-drivers devices` which will list the optimal (non-free) NVIDIA driver
* on Debian, you have `nvidia-detect` which is part of **non-free** sources (related to Bitwig apt settings below)

```
# in /etc/apt/sources.list
# non-free drivers
deb http://deb.debian.org/debian/ sid main contrib non-free

# 
sudo apt install nvidia-legacy-XXXX-driver firmware-misc-nonfree
```

## NVTV

```
sudo apt build-dep nvtv
sudo ./configure
sudo make && sudo ./src/nvtv 
```

**IMPORTANT**

* nvtv must be run with **sudo**
* from the source comments, we see stuff like:

```
# WORKING
GeForce2 MX card and Brooktree 869 chip
Brooktree Huge
Geforce2Go
Voodoo3

# NOT WORKING
GeForce4 MX, GeForce4 GO or GeForce MX GPU card
Riva128
```

**IMPORTANT**

* card definitions list header is added to this repo (`xf86PciInfo.h`)- **this is the way**
* now we need to add a card definition to this, which we need to find various PCI informations ("probing PCI")...
* `lspci` gives us everything we neeed, either `lspci` or `lspci -nn`

```
lspci -nn

# [XXXX:XXXX] is the vendor ID (ie. NVIDIA, already aadded) and device ID (which we add)
# so for NVIDIA, online is says "10DE" which exists, and "05e3" which hasn't been added
# also confirmed here: https://envytools.readthedocs.io/en/latest/hw/pciid.html
# and we add this to xf86PciInfo.h

sudo ./src/nvtv -N -d

# fails as "bnv open" as it tries communicating

```

**CONCLUSION**

NVTV finishes around early 2000s - hardware of GPUs with TV out probably changes since then - lost to the sands of time.

## NVIDIA Overscan / Underscan

* NVIDIA X Server Settings - seems to only effect drawing to the texture output, so switching to 800x600 (closest to 720x576) and they playing with overscan, you will see overscan. Set to 1024x768 and you don't see it at all, set to 640x400 and you see a lot of it
* NVTV seems to be the way to go - but doesn't do anything?


## Bitwig Installation

For Bitwig on Debian:

* added testing / experimental to sources, but made sure priorities were set (ie. everything installs from stable, UNLESS, its not found)
* this allows me to install missing packages: libxcb-util1
* then add i386 architecture support, for everything else
* then find a Bitwig version that plays nice

**Notes**

* fleamarket MOBO and CPU - Intel Core Quad Q6600 @ 2.4Ghz, 8GB RAM
* Debian 10 (Buster) - Linux 4.19 for no surprises
* minimum Bitwig is 3.2.8, because _a CPU which supports the SSE4.1 instruction set is required to run Bitwig Studio. (since version 3.3)_

```
4.0.1 = SSE4.1 neede
4.0.X >= Audio Editing + Events
3.3.11 = SSE4.1 needed
3.2.8 = JVM error on 1st boot, critical error when closed (X button) - restarts desktop
3.2.7 = JVM error - same as above
3.0.X >= The Grid + Synthesis
2.5.1 = untested...
2.0.X >= Modulators + Controls
1.3.16 = works smoothly, no glitches, fast
```

**/etc/apt/sources.list**

```
# appended line...

# extra packages (danger!)

deb http://deb.debian.org/debian/ testing main contrib
deb-src http://deb.debian.org/debian/ testing main contrib

```

**/etc/apt/preferences.d/stable.pref**

```
Package: *
Pin: release a=stable
Pin-Priority: 900
```

**/etc/apt/preferences.d/testing.pref**

```
Package: *
Pin: release a=testing
Pin-Priority: 400
```

**/etc/apt/preferences.d/unstable.pref**

```
Package: *
Pin: release a=unstable
Pin-Priority: 50
```

**/etc/apt/preferences.d/experimental.pref**

```
Package: *
Pin: release a=experimental
Pin-Priority: 1
```

**And then...**

```
sudo dpkg --add-architecture i386 
sudo apt install ./bitwig-studio-X.X.X.deb
```

