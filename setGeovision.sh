#!/bin/bash 

sudo modprobe -r bttv && sudo modprobe bttv card=157,157,157,157
ls /dev/video*

sudo nvidia-xconfig --tv-standard PAL-B

for i in {0..3}
do
	v4l2-ctl --device /dev/video$i --set-fmt-video=width=720,height=576,pixelformat=UYVY,field=none
	echo PAL set for /dev/video$i
done


# <f|field> can be one of the following field layouts:
# any, none, top, bottom, interlaced, seq_tb, seq_bt,
# alternate, interlaced_tb, interlaced_bt
# <c|colorspace> can be one of the following colorspaces:
# smpte170m, smpte240m, rec709, 470m, 470bg, jpeg, srgb,
# oprgb, bt2020, dcip3
# <xf|xfer> can be one of the following transfer functions:
# default, 709, srgb, oprgb, smpte240m, smpte2084, dcip3, none
# <y|ycbcr> can be one of the following Y'CbCr encodings:
# default, 601, 709, xv601, xv709, bt2020, bt2020c, smpte240m
# <hsv|hsv> can be one of the following HSV encodings:
# default, 180, 256
# <q|quantization> can be one of the following quantization methods:
# default, full-range, lim-range