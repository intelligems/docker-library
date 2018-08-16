#!/bin/bash

# set -e

config_file=/etc/sentry/config.yml
secrets_folder=/run/secrets


function set_config_target() {
    #escape invalid characters
    #for escape options, check this link http://www.linuxquestions.org/questions/programming-9/passing-variables-which-contain-special-characters-to-sed-4175412508/
    escaped="$3"

	#escape all backslashes first
	escaped="${escaped//\\/\\\\}"

    #escape slashes
    escaped="${escaped//\//\\/}"
    #finally make the replacement
    sed -ri "s/^(\s*)($1\s*:\s*$2\s*$)/\1$1: $escaped/" $4
}


# Read secrets from swarm

if [ -e $secrets_folder/aws_access_key_id ]; then
    AWS_ACCESS_KEY_ID=$(cat $secrets_folder/aws_access_key_id)
fi


if [ -e $secrets_folder/aws_secret_access_key ]; then
    AWS_SECRET_ACCESS_KEY=$(cat $secrets_folder/aws_secret_access_key)
fi


if [ -e $secrets_folder/s3_bucket_name ]; then
    S3_BUCKET_NAME=$(cat $secrets_folder/s3_bucket_name)
fi


if [ -e $secrets_folder/sentry_superuser ]; then
    SENTRY_SUPERUSER=$(cat $secrets_folder/sentry_superuser)
fi


if [ -e $secrets_folder/sentry_superpassword ]; then
    SENTRY_SUPERPASSWORD=$(cat $secrets_folder/sentry_superpassword)
fi

# Make replacements

if [ ! -z "$AWS_ACCESS_KEY_ID" ]; then
    set_config_target "access_key" "AKIXXXXXX" "$AWS_ACCESS_KEY_ID" $config_file
fi


if [ ! -z "$AWS_SECRET_ACCESS_KEY" ]; then
    set_config_target "secret_key" "XXXXXXX" "$AWS_SECRET_ACCESS_KEY" $config_file
fi


if [ ! -z "$S3_BUCKET_NAME" ]; then
    set_config_target "bucket_name" "BKKK" "$S3_BUCKET_NAME" $config_file
fi

# Run migrattions and create sentry superuser

if [[ "$FIRST_RUN" == "1" ]]; then
    sentry upgrade --noinput && \
    sentry createuser \
        --email "$SENTRY_SUPERUSER" \
        --password "$SENTRY_SUPERPASSWORD" \
        --superuser \
        --no-input
fi


exec "$@"