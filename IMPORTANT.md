# VERY IMPORTANT

General notes on Debian Buster installation on flea market PCs.

## Synology Recovery

https://kb.synology.com/en-my/DSM/tutorial/How_can_I_recover_data_from_my_DiskStation_using_a_PC

## NVTV

Fuck me, got it working

```
nvtv --help
nvtv -n 
# -n is to use "/dev/nv" cards, holy shit
```

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

