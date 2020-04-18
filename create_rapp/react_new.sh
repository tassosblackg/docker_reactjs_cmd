#!/bin/bash
# set -xv
bord=0

get_container_id (){
    docker ps | grep $1 | awk '{print $1}'

}

# nodere="node"
# container_id=$( get_container_id $nodere )
#
# echo $container_id
# while loop to arg-parse
while [[ "$#" -gt 0 ]];
    do case $1 in
      -b|--build_create) new_name="$2" bord=1; shift;;
      # -u|--uglify) uglify=1;;
      # *) echo "Unknown parameter passed: $1"; exit 1;;
      *) new_name="$1";;
    esac; shift;
done

# echo "Should deploy? $new_name"
# echo "Should uglify? $bord"

host_path="/home/tassos/reactjs_proj/"${new_name}
workdir="/usr/src/app/new_pro/"
img_name="reactjs:latest"

# create new project folder if not exists already
if [ ! -d "$host_path" ]; then
     mkdir -p ${host_path}
else
    echo '[**ERROR**] host path already exists! >'${host_path}
    exit 127
fi

if [ $bord -eq 1 ];then
    echo "[starting bulding docker image ...]"
    docker build --rm -t ${img_name} .

    echo "[Runing image].."
    docker run -it -d ${img_name} bash
    # get container's id
    container_id=$( get_container_id ${img_name} )

    echo "[Copying files from runing container to host].."
    docker cp ${container_id}:${workdir} $host_path

    echo "[Copied]! exiting.. stoping container"
    docker stop ${container_id}
    echo "[Stoped] container_id: "${container_id}
else
    echo -e "Runing in detach mode..\n"

    docker run -d -it ${img_name} bash | docker cp ${container_id}:${working_dir} ${host_path}
    echo "q"
    container_id=$( get_container_id ${img_name} )
    echo "w"
    docker cp -a ${container_id}:${workdir} $host_path
    docker stop ${container_id}

    echo  "New project created :"${host_path}
    echo -e "\n Container [$container_id] stoped"
fi
