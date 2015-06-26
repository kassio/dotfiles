#!/usr/bin/env bash

boot2docker start

eval "$(boot2docker shellinit)"

docker version
