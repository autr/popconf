#!/bin/zsh
sudo modprobe -r bttv
sudo modprobe bttv card=157,157,157,157 vbibufs=32 gbuffers=32
# for i in {0..3}; do v4l2-ctl --device /dev/video$i --set-fmt-video=width=720,height=576 & done