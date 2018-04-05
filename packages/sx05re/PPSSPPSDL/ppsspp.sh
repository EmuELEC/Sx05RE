#!/bin/sh

ARG=${1//[\\]/}
         
SDL_AUDIODRIVER=alsa PPSSPPSDL "$ARG" > /dev/null 2>&1
