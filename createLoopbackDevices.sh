#!/bin/zsh

sudo modprobe -r v4l2loopback

if [[ $? -ne 0 ]]; then
  echo "✸ Error occurred during 'sudo modprobe -r v4l2loopback'."
  exit 1
fi

echo "✸ Removed v4l2loopback"

sleep 1

devices=$(find /dev -name "video*" | wc -l)
video_nr=$(seq -s ',' 100 $((100 + devices - 1)))
card_label="CCTV"

sudo modprobe v4l2loopback devices=$devices video_nr=$video_nr card_label=$card_label exclusive_caps=1

echo "✸ Creating $devices devices ($video_nr), with name: $card_label"

sleep 1

process_pids=()

for ((i=0; i<devices; i++)); do
  sudo chmod 660 /dev/video$i
  echo "✸ Configuring /dev/video$i"
  sleep 0.5

  idx=$((100 + i))
  ffmpeg -f v4l2 -i /dev/video$i -vf format=yuv420p -f v4l2 /dev/video$idx >> ~/.video$idx.log.txt 2> ~/.video$idx.error.txt &
  process_pids+=($!)
  echo "✸ Streaming /dev/video$i to /dev/video$idx"

  # sleep 1
  # sudo chmod 000 /dev/video$i
  # echo "✸ Disabled /dev/video$i"

  sleep 0.5
done

echo "✸ Total pids: $process_pids"

v4l2-ctl --list-devices