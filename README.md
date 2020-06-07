## Practical Docker Tools

[![](https://gitlab.com/instantlinux/docker-tools/badges/master/pipeline.svg)](https://gitlab.com/instantlinux/docker-tools/pipelines "pipelines")

Kubernetes is hard--or is it? This repo is a collection of images and
container resource definitions for managing a software-dev
organization using Kubernetes with tools to make it easier. Contents:

| Directory | Description |
| --------- | ----------- |
| ansible | build your own cluster (Kubernetes or Swarm) |
| images | images which are published to Docker Hub |
| k8s | container resources in kubernetes yaml format |
| lib/build | build makefile and tools |
| services | non-clustered docker-compose services |
| ssl | PKI certificate tools (deprecated by k8s) |
| stacks | container resources in docker-compose format |

Find images at [docker hub/instantlinux](https://hub.docker.com/r/instantlinux/).
Find a lot more details about the Kubernetes bare-metal installer in [k8s/README](k8s/README.md).

### Kubernetes capabilities

The cluster-deployment tools here include ansible playbooks to spin up bare-metal or VM master/worker nodes, and a Makefile to add several additional features.

* Pod security policies
* Direct-attached SSD local storage pools
* Dashboard
* Non-default namespace with its own service account (full permissions
  within namespace, limited read-only in kube-system namespaces)
* Helm with tiller
* Mozilla [sops](https://github.com/mozilla/sops/blob/master/README.rst) with encryption (to keep credentials in local git repo)
* Encryption for internal etcd
* MFA using [Authelia](https://github.com/clems4ever/authelia) and Google Authenticator
* Calico or flannel networking
* ingress-nginx
* Local-volume sync
* Automatic certificate issuing/renewal with Letsencrypt

### Resource definitions

**Developer infrastructure**

| Service | Version | Notes |
| --- | --- | --- |
| artifactory | ** | binary repo |
| gitlab | ** | CI server and git repo |
| admin-git | [![](https://images.microbadger.com/badges/version/instantlinux/git-pull.svg)](https://microbadger.com/images/instantlinux/git-pull "Version badge") | sync git repo across swarm |
| jira | ** | ticket tracking |
| mariadb-galera | [![](https://images.microbadger.com/badges/version/instantlinux/mariadb-galera.svg)](https://microbadger.com/images/instantlinux/mariadb-galera "Version badge") | automatic cluster setup|
| nexus | ** | binary repo with docker registry |
| python-builder | [![](https://images.microbadger.com/badges/version/instantlinux/python-builder.svg)](https://microbadger.com/images/instantlinux/python-builder "Version badge") | CI testing for python|
| python-wsgi | [![](https://images.microbadger.com/badges/version/instantlinux/python-wsgi.svg)](https://microbadger.com/images/instantlinux/python-wsgi "Version badge") | WSGI runtime for python flask apps|
| wordpress | ** | |

**Networking and support**

| Service | Version | Notes |
| --- | --- | --- |
| authelia | ** | single-signon multi-factor auth |
| cloud | ** | nextcloud, private sync like Apple iCloud |
| docs | [![](https://images.microbadger.com/badges/version/instantlinux/open-xchange-appsuite.svg)](https://microbadger.com/images/instantlinux/open-xchange-appsuite "Version badge") | OX Appsuite, private cloud like Google Docs |
| data-sync | [![](https://images.microbadger.com/badges/version/instantlinux/data-sync.svg)](https://microbadger.com/images/instantlinux/data-sync "Version badge") | poor-man's SAN for persistent storage |
| duplicati | [![](https://images.microbadger.com/badges/version/instantlinux/duplicati.svg)](https://microbadger.com/images/instantlinux/duplicati "Version badge") | backups |
| ez-ipupdate | [![](https://images.microbadger.com/badges/version/instantlinux/ez-ipupdate.svg)](https://microbadger.com/images/instantlinux/ez-ipupdate "Version badge") | Dynamic DNS client |
| haproxy-keepalived | [![](https://images.microbadger.com/badges/version/instantlinux/haproxy-keepalived.svg)](https://microbadger.com/images/instantlinux/haproxy-keepalived "Version badge") | load balancer |
| guacamole | ** | authenticated remote-desktop server |
| logspout | ** | central logging for Docker |
| mysqldump | [![](https://images.microbadger.com/badges/version/instantlinux/mysqldump.svg)](https://microbadger.com/images/instantlinux/mysqldump "Version badge") | per-database alternative to xtrabackup |
| nagiosql | [![](https://images.microbadger.com/badges/version/instantlinux/nagiosql.svg)](https://microbadger.com/images/instantlinux/nagiosql "Version badge") | NagiosQL with Nagios Core v4 for monitoring |
| nut-upsd | [![](https://images.microbadger.com/badges/version/instantlinux/nut-upsd.svg)](https://microbadger.com/images/instantlinux/nut-upsd "Version badge") | Network UPS Tools |
| rsyslogd | ** | logger in a 13MB image |
| samba | [![](https://images.microbadger.com/badges/version/instantlinux/samba.svg)](https://microbadger.com/images/instantlinux/samba "Version badge") | file server |
| samba-dc | [![](https://images.microbadger.com/badges/version/instantlinux/samba-dc.svg)](https://microbadger.com/images/instantlinux/samba-dc "Version badge") | Active-Directory compatible domain controller |
| [secondshot](https://github.com/instantlinux/secondshot) | [![](https://images.microbadger.com/badges/version/instantlinux/secondshot.svg)](https://microbadger.com/images/instantlinux/secondshot "Version badge") | rsnapshot-based backups |
| splunk | ** | the free version |

**Email**

| Service | Version | Notes |
| --- | --- | --- |
| blacklist | [![](https://images.microbadger.com/badges/version/instantlinux/blacklist.svg)](https://microbadger.com/images/instantlinux/blacklist "Version badge") | a local rbldnsd for spam control |
| dovecot | [![](https://images.microbadger.com/badges/version/instantlinux/dovecot.svg)](https://microbadger.com/images/instantlinux/dovecot "Version badge") | imapd server |
| postfix | [![](https://images.microbadger.com/badges/version/instantlinux/postfix.svg)](https://microbadger.com/images/instantlinux/postfix "Version badge") | compact general-purpose image in 11MB |
| postfix-python | [![](https://images.microbadger.com/badges/version/instantlinux/postfix-python.svg)](https://microbadger.com/images/instantlinux/postfix-python "Version badge") | postfix with spam-control scripts |
| rainloop | ** | webmail imapd-client server |
| squirrelmail | [![](https://images.microbadger.com/badges/version/instantlinux/squirrelmail.svg)](https://microbadger.com/images/instantlinux/squirrelmail "Version badge") | older version of Squirrelmail |
| spamassassin | [![](https://images.microbadger.com/badges/version/instantlinux/spamassassin.svg)](https://microbadger.com/images/instantlinux/spamassassin "Version badge") | spam control daemon |

**Entertainment**

| Service | Version | Notes |
| --- | --- | --- |
| davite | [![](https://images.microbadger.com/badges/version/instantlinux/davite.svg)](https://microbadger.com/images/instantlinux/davite "Version badge") | party-invites manager like eVite |
| mt-daapd | [![](https://images.microbadger.com/badges/version/instantlinux/mt-daapd.svg)](https://microbadger.com/images/instantlinux/mt-daapd "Version badge") | iTunes server |
| mythtv-backend | [![](https://images.microbadger.com/badges/version/instantlinux/mythtv-backend.svg)](https://microbadger.com/images/instantlinux/mythtv-backend "Version badge") | MythTV backend |
| weewx | [![](https://images.microbadger.com/badges/version/instantlinux/weewx.svg)](https://microbadger.com/images/instantlinux/weewx "Version badge") | Weather station software (Davis VantagePro2 etc.) |
| wxcam-upload | [![](https://images.microbadger.com/badges/version/instantlinux/wxcam-upload.svg)](https://microbadger.com/images/instantlinux/wxcam-upload "Version badge") | Upload webcam images to Weather Underground |

### Credits

Thank you to the following contributors!

* [Chad Hedstrom](https://github.com/Hadlock) - [personal site](http://nearlydeaf.com/)
* [Sean Mollet](https://github.com/SeanMollet)
* [Juan Manuel Carrillo Moreno](https://github.com/inetshell) - [personal site](https://wiki.inetshell.mx/)
* [nicxvan]( https://github.com/nicxvan)
* [Frank Riley](https://github.com/fhriley)
* [Devin Bayer](https://github.com/akvadrako)

Contents created 2017-20 under [Apache 2.0 License](https://www.apache.org/licenses/LICENSE-2.0) by Rich Braun.
