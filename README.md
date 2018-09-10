TYPO3 CMS Docker Image
====

Abstract
----

This is a opinionated Docker image to run the latest TYPO3 CMS for development
purposes.

Usage
----

```bash
mkdir -p ~/Developer/cron/my-typo3-demo
cd ~/Developer/cron/my-typo3-demo
cat <<EOF >docker-compose.yml
---
version: '3.1'
services:
  web:
    image: typo3-debian:latest
    ports:
      - '8000:80'
    links:
      - db
  db:
    # see https://hub.docker.com/_/mysql/
    image: mysql:latest
    command: --default-authentication-plugin=mysql_native_password
    restart: always
    environment:
      MYSQL_RANDOM_ROOT_PASSWORD: "yes"
      MYSQL_DATABASE: typo3app
      MYSQL_USER: typo3app
      MYSQL_PASSWORD: "typo3app"
EOF
```

### TYPO3 Site Configuration

Open a Web-Browser

```
open http://$(docker-machine ip $DOCKER_MACHINE_NAME):8000/web/
```

Configure the site using the above credentials for the MySQL Database:

* Hostname: `db`
* DB Username: `typo3app`
* DB Password: `typo3app`
* Existing database: `typo3app`

----

Development
----

### Build this image locally

```
docker build -t typo3-debian:latest ./app
```

Author
----

Remus Lazar (rl at cron dot eu)
