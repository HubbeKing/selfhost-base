# Selfhosting reverse-proxy for Docker services

- Includes nginx, fail2ban, watchtower, and portainer
- Relies on externally created `web` docker network - see [docker-compose.yml](./docker-compose.yml)
    - Can be created using `docker network create web`
- All sites this backend should proxy to should be attached to the `web` network
    - This can be done in several ways:
        - setting `networks: default: name: 'web' external: true` in a `docker-compose.yml` file at the top level
        - Running the docker service using `docker run -d --network="web"` or similar

## Setup

- Get a domain name and set up DNS for it
    - Cloudflare is free, good, and makes it easy to get wildcard SSL certificates from LetsEncrypt
    - Other DNS providers are available
    - It's easiest to just set up a wildcard A record for your domain
- Obtain wildcard cert for nginx, put into [nginx/ssl](./nginx/ssl) folder.
    - Cert can be obtained through LetsEncrypt, provided one is using a supported DNS provider.
    - nginx needs the following certificate files:
        - `chain.pem`
        - `fullchain.pem`
        - `privkey.pem`
- Check watchtower config, it's set to update everything at 4AM every day.
    - The included [docker-compose.yml](./docker-compose.yml) file uses the TZ environment variable to set the timezone for watchtower
- See [nginx/templates](./nginx/templates) for Docker site config templates (and also weechat)
    - Configs for individual sites should be in [nginx/sites](./nginx/sites) folder on nginx container startup
    - Config files can be named whatever they wish, but the included [nginx.conf](./nginx/nginx.conf) file only loads `*.conf`

## TL;DR

- Create an .env file, for TZ env var and other handy things
- Create docker network using `docker network create web`
- Get some services up and attached to `web`
- Create nginx configs for services and store them in [nginx/sites](./nginx/sites) folder
    - Note: `portainer` is included in this stack. It also needs a site config. See [nginx/templates](./nginx/templates)
- Start up nginx and its friends with `docker-compose up -d`

## Recommendations

- Add `Content-Security-Policy` header to each site config, using `add_header Content-Security-Policy` config option
    - This will likely need testing and tweaking to find out what works and what doesn't
    - See https://infosec.mozilla.org/guidelines/web_security#content-security-policy for more information
