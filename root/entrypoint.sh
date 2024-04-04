#!/bin/bash

adb connect $SCRCPY_IP
sleep 3s
scrcpy --no-video >/dev/null 2>&1 &
ffmpeg -re -stream_loop -1 -f alsa -i default -acodec libopus -b:a 64k -compression_level 0 -frame_duration 2.5 -application lowdelay -packet_loss 50 -async 50 -f rtsp $RTSP_SERVER >/dev/null 2>&1 &