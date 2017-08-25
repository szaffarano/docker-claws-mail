#!/bin/bash

IMAGE="szaffarano/claws-mail:3.15.0"

docker run --rm \
  -e DISPLAY=unix$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -v "${CLAWS_HOME:-$HOME/claws}":"/home/user" \
  ${IMAGE} $@
