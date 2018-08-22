#!/bin/bash

secrets_folder=/run/secrets

function read_secret() {
    echo "Please type the secret file you want to read: "
    read -r secret_name

    if [ -f "$secrets_folder/$secret_name" ]
    then
        cat "$secrets_folder/$secret_name"
        exit 0
    else
        echo "File $secret_name does not exist."
        exit 1
    fi
}

echo "#######################"
echo "#                     #"
echo "#  Vault Reader v1.0  #"
echo "#                     #"
echo "#######################"
echo ""


echo "Username: "

read -r USERNAME

echo "Password: "

read -rs PASSWORD

if [ -f $secrets_folder/vault_username ] && [ -f $secrets_folder/vault_password ] && [ "$USERNAME" == "$(cat $secrets_folder/vault_username)" ] && [ "$PASSWORD" == "$(cat $secrets_folder/vault_password)" ]
then
    read_secret
else
    echo "Your credentials are incorrect. Exiting now..."
    exit 1
fi