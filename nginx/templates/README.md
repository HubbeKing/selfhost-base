## Templates for nginx site configs

- Working, somewhat simple templates for nginx to proxy to docker containers in the same network
- Each template has the following placeholders:
    - DOMAIN for the base domain name
    - HOST for the full name of the docker container or other host to proxy to
- One could easily replace these placeholders with `sed` and then output to `nginx/sites/`
    - Sites would then be available under `SERVICE_NAME.DOMAIN`
