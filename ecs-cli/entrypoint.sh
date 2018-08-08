#!/bin/bash

ln -s /ecs-cli /bin/ecs-cli

CLUSTER_NAME=${CLUSTER_NAME:-default}
CLUSTER_REGION=${CLUSTER_REGION:-us-east-1}
DEFAULT_LAUNCH_TYPE=${DEFAULT_LAUNCH_TYPE:-EC2}
CONFIG_NAME=${CONFIG_NAME:-default}

ecs-cli configure \
    --cluster "$CLUSTER_NAME" \
    --region "$CLUSTER_REGION" \
    --default-launch-type "$DEFAULT_LAUNCH_TYPE" \
    --config-name "$CONFIG_NAME"

exec "$@"