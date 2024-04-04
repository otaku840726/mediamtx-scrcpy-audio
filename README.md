# mediamtx-scrcpy-audio

Just a simple personal solution, used with ws-scrcpy
I use Flutter to write an App myself, use inappwebview to open the [NetrisTV/ws-scrcpy][ws-scrcpy] webpage (with viewport to improve resolution), and then use the headless (inappwebview) background to open the audio webpage

The following is a simple method to play mobile phone audio on the web page

1. Start mediamtx
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
2. Start scrcpy to push the audio to mediamtx
   [/config/.android] <- Used for adb authorization to avoid having to confirm every time you operate the phone
   ````shell
   docker run --name=mediamtx-scrcpy-audio \
   --env=SCRCPY_IP=<mobile phone ip:5555> \
   --env=RTSP_SERVER=rtsp://mediamtx:8554/myaudio1 \
   --volume=./android:/config/.android:ro  \
   ghcr.io/otaku840726/mediamtx-scrcpy-audio:latest
   ````
4. Open the audio webpage
   First use the internal network to confirm that the audio is normal. The external network needs to enable 8189/udp to use webrtc normally.
   http://mediamtx:8889/myaudio1


[ws-scrcpy]:https://github.com/NetrisTV/ws-scrcpy
