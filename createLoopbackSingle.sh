#!/bin/zsh

sudo modprobe -r v4l2loopback

if [[ $? -ne 0 ]]; then
  echo "✸ Error occurred during 'sudo modprobe -r v4l2loopback'."
  exit 1
fi

echo "✸ Removed v4l2loopback"

sleep 1

v4l2-ctl --device /dev/video0 --set-fmt-video=width=720,height=576

echo "✸ Set /dev/video0 to 720x576 PAL"

sleep 1
devices=$(find /dev -name "video*" | wc -l)
video_nr=$(seq -s ',' 100 $((100 + devices - 1)))
card_label="CCTV"

sudo modprobe v4l2loopback devices=1 video_nr=$video_nr card_label=$card_label exclusive_caps=1

echo "✸ Creating single $devices device ($video_nr), with name: $card_label"

sleep 1

ffmpeg -f v4l2 -i /dev/video0 -vf format=yuv420p -f v4l2 /dev/video100