# OpenEyes Installer

This repo contains a Dockerfile, scripts and config files in order to create a docker container to run the OpenEyes MySQL database.

## Build

```docker build -t davet1985/openeyes-mysql:<version> .```

## Run

```docker run -it -p 3306:3306 davet1985/openeyes-mysql:<version>```

## Push

```docker push davet1985/openeyes-mysql:<version>```

_Note: the version should be something like __1.11.1___
