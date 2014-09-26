#!/bin/bash
server=$(hostname -I)
raspivid -t 0 -w 1280 -h 720 -fps 30 -hf -vf -b 4000000 -0 - | \
gst-launch-1.0 -v fdsrc ! \
h264parse ! \
video/x-h264, framerate=30/1 ! \
rtph264pay config-interval=1 pt=96 ! \
gdppay ! \
tcpserversink host=$server port=5000
