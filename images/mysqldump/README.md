## mysqldump
[![](https://images.microbadger.com/badges/version/instantlinux/mysqldump.svg)](https://microbadger.com/images/instantlinux/mysqldump "Version badge") [![](https://images.microbadger.com/badges/image/instantlinux/mysqldump.svg)](https://microbadger.com/images/instantlinux/mysqldump "Image badge") [![](https://images.microbadger.com/badges/commit/instantlinux/mysqldump.svg)](https://microbadger.com/images/instantlinux/mysqldump "Commit badge")

This dockerizes a simple script I wrote in 2008 to perform a daily dump of
the MySQL databases in a Percona Galera cluster. This image is based on
MariaDB 10.3.x client.

This Docker compose service definition will cause a dump to happen
at the default hour (3:30am in $TZ) from a server named dbhost onto
a subdirectory "mysql" in volume "backup".

### Usage
Before running it, grant access to a mysql user thus:
~~~
    mysql> GRANT SELECT,RELOAD,SUPER,REPLICATION CLIENT ON *.* TO
      '$USER'@'10.%' IDENTIFIED BY '$PSWD';
~~~
Make sure the named volume "backup" exists, and that
your mysql-backup secret contains the $PSWD you've set:
~~~
    # docker volume create backup
    # docker secret create mysql-backup - <<EOT
    user=bkp
    password=$PSWD
    EOT
~~~
Optionally, add this role user to your Docker host:
~~~
    useradd -u 210 -c "Mysql backups" -s /bin/bash mysqldump
~~~
(Not recommended: an alternative user can be specified if you override
the entrypoint to invoke _adduser_, and define the USERNAME environment
variable.)

Retention is set by a variable $KEEP_DAYS which defaults to 31: within
the directory you will find a subdirectory dbhost, and within that a
separate directory for each day of the month. If you set $KEEP_DAYS
to 7, it will keep a directory for each day of the week. Backups older
than $KEEP_DAYS will be automatically removed.

### Variables

| Variable | Default | Description |
| -------- | ------- | ----------- |
| HOUR | 3 |cron-syntax backup hour |
| KEEP_DAYS | 31 | days of snapshots to keep |
| LOCK_FOR_BACKUP | | true if using Percona, blank for MariaDB |
| MINUTE | 30 | cron-syntax minutes past hour |
| SERVERS | dbhost | servers (space-separated list) to back up |
| USERNAME | mysqldump | username to run as |
| TZ | UTC | time zone |

### Notes

Dumps run in parallel in order to use available multi-core CPUs
(mainly for compression). The script doesn't provide a way to limit
the number of simultaneous runs, so if your server has many databases,
it could consume excessive memory or CPU.

It's tested on MariaDB, so the LOCK_FOR_BACKUP parameter isn't really
supported unless someone submits a pull-request to make this work with
Percona again.

[![](https://images.microbadger.com/badges/license/instantlinux/mysqldump.svg)](https://microbadger.com/images/instantlinux/mysqldump "License badge")
