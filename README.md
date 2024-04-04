# mediamtx-scrcpy-audio

Just a simple personal solution, used with ws-scrcpy
I use Flutter inappwebview to open the ws-scrcpy webpage, and then use the headless (inappwebview) background to open the audio webpage

1. Start mediamtx
   ````shell
   docker run --name=mediamtx --env=MTX_WEBRTCADDITIONALHOSTS=<外部公網IP>,<內網主機IP> -p 1935:1935 -p 8189:8189 -p 8189:8189/udp -p 8554:8554 -p 8888:8888 -p 8889:8889 -p 8890:8890/udp  bluenviron/mediamtx
   ````
2. Start scrcpy to push the audio to mediamtx
   ````shell
   docker run --name=scrcpy5 --env=SCRCPY_IP=<手機IP:5555> --env=RTSP_SERVER=rtsp://mediamtx:8554/myaudio1 --volume=/mnt/user/appdata/scrcpy:/config/.android:ro  ghcr.io/otaku840726/mediamtx-scrcpy-audio:latest
   ````
3. Open the audio webpage
   http://mediamtx:8889/myaudio1
