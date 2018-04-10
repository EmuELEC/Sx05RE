#!/bin/sh

ARG=${1//[\\]/}
         
SDL_AUDIODRIVER=alsa PPSSPPSDL "$ARG"
