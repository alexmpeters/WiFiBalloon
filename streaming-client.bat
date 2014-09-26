gst-launch-1.0 -v tcpclientsrc host=10.24.221.100 port=5000 ! ^
gdpdepay ! ^
rtph264depay ! ^
video/x-h264, framerate=30/1, bitrate=4000, profile=main, level=4.1 ! ^
avdec_h264 ! ^
timeoverlay halignment=left valignment=bottom text="Stream time:" shaded-background=true ! ^
tee name=tee ! ^
queue ! ^
videoconvert ! ^
x264enc bitrate=4000 key-int-max=50 bframes=0 byte-stream=false aud=true tune=zerolatency ! ^
h264parse ! ^
video/x-h264, profile=main, level=(string)4.1 ! ^
queue ! ^
mux. ^
audiotestsrc is-live=true ! ^
audio/x-raw, format=S16LE, endianness=1234, signed=true, width=16, depth=16, rate=44100, channels=2 ! ^
queue ! ^
voaacenc bitrate=128000 ! ^
aacparse ! ^
audio/mpeg, mpegversion=4, stream-format=raw ! ^
queue ! ^
flvmux streamable=true name=mux ! ^
queue ! ^
rtmpsink location="rtmp://a.rtmp.youtube.com/live2/ethanharstad.7tkr-kpwm-yvy0-6vqt live=true flashver=FMLE/3.0(compatible;FMSc/1.0)" ^
tee. ! ^
autovideosink sync=false > out.txt
