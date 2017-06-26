#!/usr/bin/env bash

mem="MEM $(ps -A -o %mem | awk '{s+=$1} END {print s "%"}')"
cpu="CPU $(ps -A -o %cpu | awk '{s+=$1} END {print s "%"}')"

echo "${mem} ${cpu} | size=12"
