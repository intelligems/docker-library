#!/bin/bash

file_output=report.txt
[[ -f $file_output ]] && rm $file_output

docker_service_name=$(docker service ls | grep vault | awk '{print $2}')

docker exec -it $(docker ps -f name="${docker_service_name}" -q) vault 2>&1 | tee "$file_output"