# Psql - Postgres Client

## Usage

- Connect to a remote Postgres Database

```Shell
docker run -it --rm \
    -e POSTGRES_USER=$POSTGRES_USER \
    -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
    -e POSTGRES_HOST=$POSTGRES_HOST \
    -e POSTGRES_DB=$POSTGRES_DB \
    intelligems/psql:latest \
    psql -U $POSTGRES_USER -h $POSTGRES_HOST -d $POSTGRES_DB -w
```

## Default values

If you do not set environment variables, default values are:

- `POSTGRES_USER=postgres`
- `POSTGRES_PASSWORD=postgres`
- `POSTGRES_DB=postgres`
- `POSTGRES_HOST=postgres`
- `POSTGRES_PORT=5432`