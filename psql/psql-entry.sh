#!/bin/bash

if [ ! -z "$POSTGRES_USER" ] && [ ! -z "$POSTGRES_PASSWORD" ]
then
    echo "postgres:5432:postgres:$POSTGRES_USER:$POSTGRES_PASSWORD" > "${HOME}"/.pgpass
else
    echo "postgres:5432:postgres:postgres:postgres" > "${HOME}"/.pgpass
fi

exec "$@"