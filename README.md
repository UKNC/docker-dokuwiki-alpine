# docker-dokuwiki-alpine

https://hub.docker.com/r/freebyte/docker-dokuwiki-alpine/

## Setup

1. Pull the image

```bash
$ docker pull freebyte/docker-dokuwiki-alpine
```

2. Create docker named volume

```bash
$ docker volume create wiki
```

3. Find out what folder is used by the named container

```bash
$ docker volume inspect wiki
```

Example output:

```
[
    {
        "CreatedAt": "2017-12-30T15:52:20+02:00",
        "Driver": "local",
        "Labels": null,
        "Mountpoint": "/var/lib/docker/volumes/wiki/_data",
        "Name": "wiki",
        "Options": {},
        "Scope": "local"
    }
]
```

4. Copy dokuwiki folder into container's folder

Dokuwiki folder maybe either pre-existing (backuped) folder or a new dokuwiki.

For new dokuwiki:

```
$ cd /var/lib/docker/volumes/wiki/_data
$ curl https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz | tar xvz --strip-components 1
```

5. Create a new user on the host system to match docker image apache user

```bash
useradd --uid 20000 -M -N wikidocker 
```

This creates user with login wikidocker without group and home folder. apache server inside docker container runs with uid 20000, too.

6. Chown volume folder to wikidocker user

```bash
$ chown -R wikidocker /var/lib/docker/volumes/wiki/_data
```

This makes possible for apache server to access the data in the folder.

Check all is ok:

```bash 
$ ls /var/lib/docker/volumes/wiki/_data
```

Example output:
```
/var/lib/docker/volumes/wiki/_data:
total 92
drwxr-xr-x  8 wikidocker systemd-journal  4096 Dec 30 16:18 .
drwxr-xr-x  3 root       root             4096 Dec 30 16:17 ..
-rw-r--r--  1 wikidocker root            18092 Dec 30 16:18 COPYING
-rw-r--r--  1 wikidocker root              306 Dec 30 16:18 README
-rw-r--r--  1 wikidocker root               33 Dec 30 16:18 VERSION
drwxr-xr-x  2 wikidocker root             4096 Dec 30 16:18 bin
drwxr-xr-x  3 wikidocker root             4096 Dec 30 16:18 conf
drwxr-xr-x 12 wikidocker root             4096 Dec 30 16:18 data
-rw-r--r--  1 wikidocker root             3692 Dec 30 16:18 doku.php
-rw-r--r--  1 wikidocker root            19374 Dec 30 16:18 feed.php
drwxr-xr-x  8 wikidocker root             4096 Dec 30 16:18 inc
-rw-r--r--  1 wikidocker root               45 Dec 30 16:18 index.html
-rw-r--r--  1 wikidocker root             2097 Dec 30 16:18 index.php
drwxr-xr-x  8 wikidocker root             4096 Dec 30 16:18 lib
drwxr-xr-x  8 wikidocker root             4096 Dec 30 16:18 vendor
```

7. Run the container

```bash
$ docker run -d -p 8080:80 -v wiki:/var/www/localhost/htdocs wiki
```

8. Access wiki

```bash
$ firefox http://localhost:8080
```
