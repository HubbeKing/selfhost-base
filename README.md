# Selfhosting backend for Docker

Includes nginx, fail2ban, watchtower, and portainer

## Setup

- Check watchtower config, it's set to update everything at 4AM every day.

- SSL DH params should be fetched from https://ssl-config.mozilla.org/ffdhe2048.txt
- SSL DH params should be stored in [nginx/config](./nginx/config) folder as `dhparams.pem`

- See [nginx/templates](./nginx/templates) for Docker site config templates
    - Configs for individual sites should be in [nginx/sites](./nginx/sites) folder on nginx container startup
    - Config files can be named whatever they wish, but the included [nginx.conf](./nginx/nginx.conf) file only loads `*.conf`

- Wildcard cert for nginx goes into [nginx/ssl](./nginx/ssl) folder.
    - Cert can be obtained through LetsEncrypt, provided one is using a supported DNS provider.

- Relies on externally created `web` docker network - see [docker-compose.yml](./docker-compose.yml)
- Can be created using `docker network create web`
- All sites this backend should proxy to should be attached to the `web` network
- This can be done in several ways:
    - setting `networks: default: name: 'web' external: true` in a `docker-compose.yml` file at the top level
    - setting `networks: - web` for each service in a `docker-compose.yml` file
    - Running the docker service using `docker run -d --network="web"` or similar

- Tweak `Content-Security-Policy` header as needed, it's quite permissive by default - [security.conf](./nginx/configs/security.conf)

## Usage

- Create an .env file, for TZ env var and other handy things
- Create docker network using `docker network create web`
- Get things going with `docker-compose up -d`
- Get some services up and attached to `web`
- Create nginx configs for services and store them in [nginx/sites](./nginx/sites) folder
- Restart nginx with `docker restart nginx`

