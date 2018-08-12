#!/bin/sh


if [ -z "$PLUGIN_STOLOS_URL" -o -z "$STOLOS_URL" ]
then
    echo "You have not set stolos_url value or secret"
    exit 1
fi

if [ -z "$PLUGIN_USERNAME" -o -z "$USERNAME" ]
then
    echo "You have not set username value or secret"
    exit 1
fi

if [ -z "$PLUGIN_PASSWORD" -o -z "$PASSWORD" ]
then
    echo "You have not set password value or secret"
    exit 1
fi

if [ -z "$PLUGIN_PROJECT_UUID" -o -z "$PROJECT_UUID" ]
then
    echo "You have not set project_uuid value or secret"
    exit 1
fi

# Default secrets
PLUGIN_STOLOS_URL=${PLUGIN_STOLOS_URL:=$STOLOS_URL}
PLUGIN_USERNAME=${PLUGIN_USERNAME:=$USERNAME}
PLUGIN_PASSWORD=${PLUGIN_PASSWORD:=$PASSWORD}
PLUGIN_PROJECT_UUID=${PLUGIN_PROJECT_UUID:=$PROJECT_UUID}

# Default file & service
PLUGIN_FILE=${PLUGIN_FILE:-.stolos.yml}
PLUGIN_BUILD_TARGET=${PLUGIN_BUILD_TARGET:-web}

stolos login --stolos-url="$PLUGIN_STOLOS_URL" --username "$PLUGIN_USERNAME" --password "$PLUGIN_PASSWORD"
stolos projects connect "$PLUGIN_PROJECT_UUID"

stolos compose --file "$PLUGIN_FILE" build "$PLUGIN_BUILD_TARGET"

exec "$@"



