#!/bin/bash

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

# User specifies custom build targets
if [ ! -z "$PLUGIN_BUILD_TARGETS" ]; then

    # Parse drone array
    IFS=',' read -r -a BUILD_TARGETS <<< "$PLUGIN_BUILD_TARGETS"

    for TARGET in "${BUILD_TARGETS[@]}"
    do
        stolos compose --file "$PLUGIN_FILE" build "$TARGET"
    done

fi

if [ ! -z "$PLUGIN_CUSTOM_COMMANDS" ]; then
     # Parse drone array
    IFS=',' read -r -a CUSTOM_COMMANDS <<< "$PLUGIN_CUSTOM_COMMANDS"

    for CUSTOM_CMD in "${CUSTOM_COMMANDS[@]}"
    do
        eval "$CUSTOM_CMD"
    done
fi

stolos compose --file "$PLUGIN_FILE" up -d



