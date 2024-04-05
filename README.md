# mediamtx-scrcpy-audio

Just a simple personal solution, used with ws-scrcpy \
I use Flutter to write an App myself, \
use inappwebview to open the [NetrisTV/ws-scrcpy][ws-scrcpy] webpage (with viewport to improve resolution), \
and then use the headless (inappwebview) background to open the audio webpage \
\
The following is a simple method to play mobile phone audio on the web page 

1. Start [bluenviron/mediamtx][mediamtx]
   ````shell
   docker run --name=mediamtx \
   --env=MTX_WEBRTCADDITIONALHOSTS=<External public network IP>,<Internal network host IP> \
   -p 1935:1935 \
   -p 8189:8189  \
   -p 8189:8189/udp \
   -p 8554:8554 \
   -p 8888:8888 \
   -p 8889:8889 \
   -p 8890:8890/udp  \
   bluenviron/mediamtx
   ````
2. Start [Genymobile/scrcpy][scrcpy] and use ffmpeg push the audio to mediamtx \
   [/config/.android] <- Used for adb authorization to avoid having to confirm every time you operate the phone \
   The 3000 port is kasmVnc. I originally used this webpage to play audio, but the network usage was relatively high. 
   ````shell
   docker run --name=mediamtx-scrcpy-audio \
   --env=SCRCPY_IP=<mobile phone ip:5555> \
   --env=RTSP_SERVER=rtsp://mediamtx:8554/myaudio1 \
   --volume=./android:/config/.android:ro  \
   -p 3000:3000 \
   ghcr.io/otaku840726/mediamtx-scrcpy-audio:latest
   ````
4. Open the audio webpage \
   First use the internal network to confirm that the audio is normal. The external network needs to enable 8189/udp to use webrtc normally. \
   kasmVNC is about 400k/s, Mediamtx webrtc is about 30k/s \
   But of course there will be differences in sound quality. You can also use the Docerfile to rebuild it yourself. There is bitrate/compression_level/frame_duration in root/entrypoint.sh to improve it. \
   mediamtx-webrtc: http://mediamtx:8889/myaudio1 \
   kasmVNC: http://mediamtx-scrcpy-audio:3000

[scrcpy]:https://github.com/Genymobile/scrcpy
[ws-scrcpy]:https://github.com/NetrisTV/ws-scrcpy
[mediamtx]:https://github.com/bluenviron/mediamtx
