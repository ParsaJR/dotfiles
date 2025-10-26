#!/bin/bash


List=$(ps --sort -pcpu -Ao comm,pcpu | tail -n +2 | head -n 10)
notify-send --expire-time=2500 "$List"
