#!/bin/bash 

sudo modprobe -r bttv && sudo modprobe bttv card=157,157,157,157
ls /dev/video*

sudo nvidia-xconfig --tv-standard PAL-B

for i in {0..3}
do
	v4l2-ctl --device /dev/video$i --set-fmt-video=width=720,height=576,pixelformat=UYVY
	echo PAL set for /dev/video$i
done