#!/bin/sh
dir=$(dirname $0)

if [[ "$dir" == "." ]];
then
      dir=$(pwd)
      #echo "1 - $dir"
fi

build(){

    ID=$(docker images ror_260_524:master --format "{{.ID}}")
    if [[ "$ID" == "" ]];
    then
        docker build -t ror_260_524:master $dir
        echo "Create Image Successfully"
    else
        echo "Image Exist"
    fi
}

delete(){

    CN=$(docker ps -a --filter "name=rails_kinedu" --format "{{.Names}}")
    if [[ "$CN" != "" ]];
    then
        docker rm -f $CN && echo "Delete Container"
    fi

    ID=$(docker images ror_260_524:master --format "{{.ID}}")
    if [[ "$ID" != "" ]];
    then
        docker rmi $ID && echo "Delete Image Successfully"
    fi
}

new(){
    path_project=$(cd .. && pwd)

    ID=$(docker images ror_260_524:master --format "{{.ID}}")
    if [[ "$ID" != "" ]];
    then

        if [[ ! -d "$path_project/config" ]];
        then
            docker run --name rails_kinedu -v $path_project:/app ror_260_524:master ls /app

            CN=$(docker ps -a --filter "name=rails_kinedu" --format "{{.Names}}")
            if [[ "$CN" != "" ]];
            then
                docker rm -f $CN && echo "Delete Container"
            fi

        else
            echo "Project Exist!"
        fi
    else
        echo "Image not exist, execute ./app build"
    fi
}

start(){
    docker-compose up
}

stop(){
    docker-compose down
}

help() {

	APP=$(basename "$0")
	echo
	echo "Help: $APP <help|build|delete|new|start|stop>"
	echo
	echo "       $APP help                         Show the current use of the script"
	echo "       $APP build                        Build docker image RoR"
    echo "       $APP delete                       Delete docker image  RoR"
    echo "       $APP new                          Create new project of RoR"
    echo "       $APP start                        Start containers of kinedu project"
    echo "       $APP stop                         Delete containers of kinedu project"
	echo
	exit 0
}

# Get action and validate
CMD="$1"
echo "$CMD" | grep -Eq '^(help|build|delete|new|start|stop)$' || help


# Execute command
"$@"