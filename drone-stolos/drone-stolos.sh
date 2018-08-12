#!/bin/sh

# Default secrets
PLUGIN_URL=${PLUGIN_URL:=$STOLOS_URL}
PLUGIN_USERNAME=${PLUGIN_USERNAME:=$STOLOS_USERNAME}
PLUGIN_PASSWORD=${PLUGIN_PASSWORD:=$STOLOS_PASSWORD}
PLUGIN_PROJECT_UUID=${PLUGIN_PROJECT_UUID:=$STOLOS_PROJECT_UUID}

if [ -z "$PLUGIN_URL" ]
then
    echo "You have not set stolos_url value or secret"
    exit 1
fi

if [ -z "$PLUGIN_USERNAME" ]
then
    echo "You have not set username value or secret"
    exit 1
fi

if [ -z "$PLUGIN_PASSWORD" ]
then
    echo "You have not set password value or secret"
    exit 1
fi

if [ -z "$PLUGIN_PROJECT_UUID" ]
then
    echo "You have not set project_uuid value or secret"
    exit 1
fi

# Default file & service
PLUGIN_FILE=${PLUGIN_FILE:-.stolos.yml}

stolos login --stolos-url="$PLUGIN_URL" --username "$PLUGIN_USERNAME" --password "$PLUGIN_PASSWORD"
stolos projects connect "$PLUGIN_PROJECT_UUID"

if [ ! -z "$PLUGIN_BUILD_TARGET" ]; then
    stolos compose --file "$PLUGIN_FILE" build "$PLUGIN_BUILD_TARGET"
fi

stolos compose --file "$PLUGIN_FILE" up -d



