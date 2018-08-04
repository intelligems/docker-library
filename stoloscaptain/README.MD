# Stolos Captain

A [stolos.io](stolos.io) client tool, packaged with **docker-ce**, **unison** & **docker-compose**

For **stolos** documentation visit [docs.stolos.io](docs.stolos.io)

## Use cases

This image is mostly directed towards running stolos commands from CI systems such as `Gitlab-CI`, `Drone` etc.

However you can also run individual standalone commands from your local docker client instead of installing `stolosctl`.

## Usage

- To connect to a project and spin up a `docker-compose` services setup (current directory is mounted on container):

```Shell
docker run --rm \
    --mount src="$(pwd)",target=/usr/src/app/,type=bind \
    -e STOLOS_URL=$STOLOS_URL \
    -e STOLOS_USERNAME=$STOLOS_USERNAME \
    -e STOLOS_PASSWORD=$STOLOS_PASSWORD \
    -e STOLOS_PROJECT_UUID=$STOLOS_PROJECT_UUID \
    intelligems/stoloscaptain:latest \
    stolos login --stolos-url="$STOLOS_URL" --username "$STOLOS_USERNAME" --password "$STOLOS_PASSWORD" && \
    stolos projects connect "$STOLOS_PROJECT_UUID" && \
    stolos compose --file docker-compose.yml up -d
```

- Optionally if you want to use sync features you have to upload your public key

```Shell
docker run --rm \
    --mount src="$(pwd)",target=/usr/src/app/,type=bind \
    --mount src=~/.ssh/id_rsa.pub,target=/usr/src/app/id_rsa.pub,type=bind \
    -e STOLOS_URL=$STOLOS_URL \
    -e STOLOS_USERNAME=$STOLOS_USERNAME \
    -e STOLOS_PASSWORD=$STOLOS_PASSWORD \
    -e STOLOS_PROJECT_UUID=$STOLOS_PROJECT_UUID \
    intelligems/stoloscaptain:latest \
    stolos login --stolos-url="$STOLOS_URL" --username "$STOLOS_USERNAME" --password "$STOLOS_PASSWORD" && \
    stolos keys upload id_rsa.pub && \
    stolos projects connect "$STOLOS_PROJECT_UUID" && \
    stolos compose --file docker-compose.yml up -d && \
    stolos sync
```

- `STOLOS_URL`: Your organization url provided by [stolos.io](stolos.io)
- `STOLOS_USERNAME`: Your [stolos.io](stolos.io) username
- `STOLOS_PASSWORD`: Your [stolos.io](stolos.io) password
- `STOLOS_PROJECT_UUID` Individual Project uuid aqcuired by running `stolos projects list`. You can create a new project inside a project directory with `stolos projects create .`
