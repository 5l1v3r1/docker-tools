## samba

[![](https://images.microbadger.com/badges/version/instantlinux/samba.svg)](https://microbadger.com/images/instantlinux/samba "Version badge") amd64:[![](https://images.microbadger.com/badges/image/instantlinux/samba.svg)](https://microbadger.com/images/instantlinux/samba "Image badge")  arm64:[![](https://images.microbadger.com/badges/image/instantlinux/samba-arm64.svg)](https://microbadger.com/images/instantlinux/samba-arm64 "Image badge") arm32:[![](https://images.microbadger.com/badges/image/instantlinux/samba-arm32.svg)](https://microbadger.com/images/instantlinux/samba-arm-32 "Image badge") [![](https://images.microbadger.com/badges/commit/instantlinux/samba.svg)](https://microbadger.com/images/instantlinux/samba "Commit badge")

Samba as a file server. This is stripped down to the basics to enable greatest flexibility. Supported on: [amd64](https://hub.docker.com/r/instantlinux/samba/) [arm64](https://hub.docker.com/r/instantlinux/samba-arm64/) [arm32](https://hub.docker.com/r/instantlinux/samba-arm32/).

### Usage

The most-common directives can be specified in environment variables as shown below. If you need further customizations, put them in one or more files under mount point /etc/samba/conf.d. If you want to add global settings, put those into the first file with a name like 0globals.conf -- they will be appended in alphabetical-sort sequence.

Samba requires mapping between Unix user IDs and Windows identities. The simplest way to do that is create a file users.sh mounted under /etc/samba/conf.d with group and username entries in this form:
```
addgroup -g 1234 groupname
adduser -D -H -G groupname -u 5678 myself
```

and set passwords in a file /var/lib/samba/private/passwd.tdb using the smbpasswd utility after starting the container:
```
docker exec -it samba_app_1 smbpasswd -a myself
New SMB password:
Retype new SMB password:
Added user myself.
```
See [Samba IDMAP](https://www.samba.org/samba/docs/man/Samba-HOWTO-Collection/idmapper.html) documentation for the many other supported identity mapping options. This repo has complete instructions for
[building a kubernetes cluster](https://github.com/instantlinux/docker-tools/blob/master/k8s/README.md) where you can deploy [kubernetes.yaml](https://github.com/instantlinux/docker-tools/blob/master/images/samba/kubernetes.yaml) using _make_ and customizing [Makefile.vars](https://github.com/instantlinux/docker-tools/blob/master/k8s/Makefile.vars) after cloning this repo:
~~~
git clone https://github.com/instantlinux/docker-tools.git
cd docker-tools/k8s
make samba
~~~

### Variables

These variables can be passed to the image from kubernetes.yaml or docker-compose.yml as needed:

Variable | Default | Description |
-------- | ------- | ----------- |
DOMAIN_LOGONS | no | enable workgroup logon
LOGON_DRIVE | H | initial drive mapping
NETBIOS_NAME | samba | server name
SERVER_STRING | "Samba Server" | server banner string
TZ | UTC | local timezone
WORKGROUP | WORKGROUP | workgroup name

[![](https://images.microbadger.com/badges/license/instantlinux/samba.svg)](https://microbadger.com/images/instantlinux/samba "License badge") [![](https://img.shields.io/badge/code-samba_team%2Fsamba-blue.svg)](https://gitlab.com/samba-team/samba "Code repo")
