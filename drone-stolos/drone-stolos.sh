#!/bin/sh

if [ -z "$PLUGIN_STOLOS_URL" ]
then
    echo "You have not set stolos_url value"
    exit 1
fi

if [ -z "$PLUGIN_USERNAME" ]
then
    echo "You have not set username value"
    exit 1
fi

if [ -z "$PLUGIN_PASSWORD" ]
then
    echo "You have not set password value"
    exit 1
fi

if [ -z "$PLUGIN_PROJECT_UUID" ]
then
    echo "You have not set project_uuid value"
    exit 1
fi

PLUGIN_FILE=${PLUGIN_FILE:-.stolos.yml}
PLUGIN_BUILD_TARGET=${PLUGIN_BUILD_TARGET:-web}

stolos login --stolos-url="$STOLOS_URL" --username "$PLUGIN_USERNAME" --password "$PLUGIN_PASSWORD"
stolos projects connect "$PLUGIN_PROJECT_UUID"

stolos compose --file "$PLUGIN_FILE" build "$PLUGIN_BUILD_TARGET"

exec "$@"



