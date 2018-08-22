#!/bin/bash

docker_service_name=$(docker service ls | grep vault | awk '{print $2}')

docker exec -it $(docker ps -f name="${docker_service_name}" -q) vault