#!/bin/zsh

sudo modprobe -r v4l2loopback

if [[ $? -ne 0 ]]; then
	echo "✸ Error occurred during 'sudo modprobe -r v4l2loopback'."
	exit 1
fi

echo "✸ Removed v4l2loopback"

sleep 1



devices=$1
if [[ -z $1 ]]; then
  devices=$(find /dev -name "video*" | wc -l)
fi

for ((i=0; i<devices; i++)); do

	v4l2-ctl --device /dev/video$i --set-fmt-video=width=720,height=576,field=none,pixelformat=UYVY
	echo "✸ PAL /dev/video$i"
	sleep 0.1

done

video_nr=$(seq -s ',' 100 $((100 + devices - 1)))
card_label="CCTV"


sudo modprobe v4l2loopback devices=1 video_nr=100 card_label=$card_label exclusive_caps=1

echo "✸ Creating /dev/video100 from $devices devices, with name: $card_label"

sleep 0.2

process_pids=()

inputs=""
filter=""

for ((i=0; i<devices; i++)); do

	sudo chmod 660 /dev/video$i
	echo "✸ Configuring /dev/video$i"
	inputs+=" -f v4l2 -i /dev/video$i"
	filter+="[$i:v]"
	sleep 0.1
done

filter+="hstack=inputs=$devices,format=yuv420p"

v4l2-ctl --list-devices

cpu_count=$(grep -c '^processor' /proc/cpuinfo) # get total CPU cores

cmd="ffmpeg $inputs -filter_complex \"$filter\" -f v4l2 /dev/video100"
# cmd="ffmpeg $inputs -filter_complex \"$filter\" -f v4l2 -threads $cpu_count /dev/video100"

# ffmpeg  -f v4l2 -i /dev/video0 -f v4l2 -i /dev/video1 -filter_complex "[0:v][1:v]hstack=inputs=2,format=yuv420p" -f v4l2 -threads 4 -buffersize 8192 /dev/video100

# RECOMMENDATIONS FROM GUPTA:

# grep -c '^processor' /proc/cpuinfo
# ffmpeg -f v4l2 -i /dev/video0 -f v4l2 -i /dev/video1 -filter_complex "[0:v][1:v]hstack=inputs=2,format=yuv420p" -f v4l2 -threads 4 /dev/video100

# increase buffer ( default is 4096 )
# ffmpeg -f v4l2 -i /dev/video0 -f v4l2 -i /dev/video1 -filter_complex "[0:v][1:v]hstack=inputs=2,format=yuv420p" -f v4l2 -buffersize 8192 /dev/video100


echo "✸ $cmd"

eval $cmd 
# >> ~/.video.quad.log.txt 2> ~/.video.quad.error.txt &
