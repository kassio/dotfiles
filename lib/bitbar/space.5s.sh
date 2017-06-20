#!/usr/bin/env bash

echo "CPU $(ps -A -o %cpu | awk '{s+=$1} END {print s "%"}') | size=12"
