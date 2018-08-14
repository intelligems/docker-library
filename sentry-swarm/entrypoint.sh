#!/bin/bash -e

# set -e

config_file=/etc/sentry/config.yml

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

# if [[ "$SWARM_MODE" == "1" ]]; then
#     export SENTRY_SECRET_KEY=$(cat /run/secrets/sentry_secret_key)
#     export SENTRY_DB_NAME=$(cat /run/secrets/sentry_db_name)
#     export SENTRY_DB_USER=$(cat /run/secrets/sentry_db_user)
#     export SENTRY_DB_PASSWORD=$(cat /run/secrets/sentry_db_password)
#     export SENTRY_SUPERUSER=$(cat /run/secrets/sentry_superuser)
#     export SENTRY_SUPERPASSWORD=$(cat /run/secrets/sentry_superpassword)
#     AWS_ACCESS_KEY_ID=$(cat /run/secrets/aws_access_key_id)
#     AWS_SECRET_ACCESS_KEY=$(cat /run/secrets/aws_secret_access_key)
#     S3_BUCKET_NAME=$(cat /run/secrets/s3_bucket_name)

# fi

export SENTRY_SECRET_KEY=$(cat /run/secrets/sentry_secret_key)
export SENTRY_DB_NAME=$(cat /run/secrets/sentry_db_name)
export SENTRY_DB_USER=$(cat /run/secrets/sentry_db_user)
export SENTRY_DB_PASSWORD=$(cat /run/secrets/sentry_db_password)
export SENTRY_SUPERUSER=$(cat /run/secrets/sentry_superuser)
export SENTRY_SUPERPASSWORD=$(cat /run/secrets/sentry_superpassword)
AWS_ACCESS_KEY_ID=$(cat /run/secrets/aws_access_key_id)
AWS_SECRET_ACCESS_KEY=$(cat /run/secrets/aws_secret_access_key)
S3_BUCKET_NAME=$(cat /run/secrets/s3_bucket_name)

if [[ "$FIRST_RUN" == "1" ]]; then
    sentry upgrade --noinput && \
    sentry createuser \
        --email "$SENTRY_SUPERUSER" \
        --password "$SENTRY_SUPERPASSWORD" \
        --superuser \
        --no-input
fi


if [ ! -z "$AWS_ACCESS_KEY_ID" ]; then
    set_config_target "access_key" "AKIXXXXXX" "$AWS_ACCESS_KEY_ID" $config_file
fi


if [ ! -z "$AWS_SECRET_ACCESS_KEY" ]; then
    set_config_target "secret_key" "XXXXXXX" "$AWS_SECRET_ACCESS_KEY" $config_file
fi


if [ ! -z "$S3_BUCKET_NAME" ]; then
    set_config_target "bucket_name" "BKKK" "$S3_BUCKET_NAME" $config_file
fi

exec "$@"