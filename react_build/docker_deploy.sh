#!/bin/bash


args=($@)
argc=${#args[@]}

img_name=${args[0]}
workdir="/usr/src/app"

# mount volume to a container
docker run -it -v ${args[1]}:$workdir -w $workdir $img_name bash
