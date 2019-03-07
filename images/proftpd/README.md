## proftpd

[![](https://images.microbadger.com/badges/version/instantlinux/proftpd.svg)](https://microbadger.com/images/instantlinux/proftpd "Version badge") [![](https://images.microbadger.com/badges/image/instantlinux/proftpd.svg)](https://microbadger.com/images/instantlinux/proftpd "Image badge") [![](https://images.microbadger.com/badges/commit/instantlinux/proftpd.svg)](https://microbadger.com/images/instantlinux/proftpd "Commit badge")

An easy-to-use, tiny yet full-featured installation of ProFTPD.

### Usage

The most-common directives can be specified in environment variables as shown below. One is required, the PASV_ADDRESS. If you need further customizations, put them in one or more files under mount points /etc/proftpd.d and /etc/proftpd/modules.d.

A single upload user can be specified via the FTPUSER_xxx variables. It is activated by defining ftp-user-password-secret thus:

    python -c "import crypt,random,string; \
      print crypt.crypt('YOURPASSWORD', '\$6\$' + ''.join( \
	[random.choice(string.ascii_letters + string.digits) \
      for _ in range(16)]))" | \
    docker secret create ftp-user-password-secret -

An example compose file is provided here in docker-compose.yml. This is for the common scenario of sharing from Docker swarm the contents of a network-attached volume as a read-only anonymous-ftp service. This repo has complete instructions for
[building a kubernetes cluster](https://github.com/instantlinux/docker-tools/blob/master/k8s/README.md) where you can deploy [kubernetes.yaml](https://github.com/instantlinux/docker-tools/blob/master/images/proftpd/kubernetes.yaml) with the Makefile or:
~~~
cat kubernetes.yaml | envsubst | kubectl apply -f -
~~~

### Variables

Variable | Default | Description |
-------- | ------- | ----------- |
ALLOW_OVERWRITE | on | allow clients to modify files
ANONYMOUS_DISABLE | off | anonymous login
ANON_UPLOAD_ENABLE | DenyAll | anonymous upload
FTPUSER_PASSWORD_SECRET | ftp-user-password-secret | hashed pw of upload user
FTPUSER_NAME | ftpuser | upload username
FTPUSER_UID | 1001 | upload file ownership UID
LOCAL_UMASK | 022 | upload umask
MAX_CLIENTS | 10 | maximum simultaneous logins
MAX_INSTANCES | 30 | process limit
PASV_ADDRESS |  | required--address of docker engine
PASV_MAX_PORT | 30100 | range of client ports (rebuild image if changed)
PASV_MIN_PORT | 30091 | 
TIMES_GMT | off | local time for directory listing
TZ | UTC | local timezone
WRITE_ENABLE | AllowAll | allow put/rm

### Secrets

Secret | Description
------ | -----------
ftp-user-password-secret | (optional) hashed pw of upload user

[![](https://images.microbadger.com/badges/license/instantlinux/proftpd.svg)](https://microbadger.com/images/instantlinux/proftpd "License badge") [![](https://img.shields.io/badge/code-proftpd%2Fproftpd-blue.svg)](https://github.com/proftpd/proftpd "Code repo")
