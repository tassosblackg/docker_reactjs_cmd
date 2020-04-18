#!/bin/bash

args=($@)
argc=${#args[@]} # name for the new app-project

host_path="/home/tassos/reactjs_proj/"${args[1]}
working_dir="/usr/src/app"
img_name="reactjs:latest"




# check number of arguments
if [ [$argc -gt 2 ] ]; then
    echo '[**ERROR**] Too many arguments excpect 2 received: '${argc}
    exit 1
else
    # ask for help
    if [ [ "$args[0]" = "-h" ] || ["$args[0]" = "--h" ] || ["$args[0]" = "-help" ] || ["$args[0]" = "--help" ] ]; then
        echo "Only two arg, first difines operations(-b or -rd) and second the (string) project_name. "
        echo "[args[0]]=> -b : for build again image from node:latest."
        echo " or [args[0]]=> -rd : run already existing image in ditach mode, &copy files."
        echo "[args[1]]=> a string with name of the new project to be created."
    else
        echo "Use reactnew --help or -h to see more."
    fi

    # create new project folder if not exists already
    if [ !-d $host_path ]; then
         mkdir -p ${host_path}
    else
        echo '[**ERROR**] host path already exists! >'${host_path}
        exit 127
    fi

    # build
    if [ ["$args[0]" = "-b"] ]; then

        echo "[starting bulding docker image ...]"
        docker build --rm -t ${img_name} .

        echo "[Runing image].."
        docker run -it -d ${img_name} bash
        # get container's id
        container_id=$(docker ps | grep $img_name | awk '{print $1}')

        echo "[Copying files from runing container to host].."
        docker cp ${container_id}:/usr/src/app/new_pro $host_path

        echo "[Copied]! exiting.. stoping container"
        docker stop ${container_id}
        echo "[Stoped] container_id: "${container_id}

    elif [ [ "$args[0]" = "-rd" ] ]; then
            #statements
            # run if you want just to create the app and get the files to the host without
            # starting working inside the conteainer
        docker run -d -it ${img_name} bash | docker cp ${img_name}:${working_dir} ${host_path} | docker stop ${container_id}
    fi
fi
