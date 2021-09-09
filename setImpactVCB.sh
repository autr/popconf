sudo modprobe -r bttv && sudo modprobe bttv card=143
ls /dev/video*

v4l2-ctl --device /dev/video0 --set-fmt-video=width=720,height=576,pixelformat=UYVY,field=none