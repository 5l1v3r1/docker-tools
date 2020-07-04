## dropbox

[![](https://img.shields.io/docker/v/instantlinux/dropbox?sort=date)](https://microbadger.com/images/instantlinux/dropbox "Version badge") [![](https://images.microbadger.com/badges/image/instantlinux/dropbox.svg)](https://microbadger.com/images/instantlinux/dropbox "Image badge") [![](https://images.microbadger.com/badges/commit/instantlinux/dropbox.svg)](https://microbadger.com/images/instantlinux/dropbox "Commit badge")

Dropbox client under Debian stretch.

*DEPRECATED* - it probably works but I'm not using it and the vendor doesn't provide versioning of its download service.

### Usage

Mount your sync contents as /home/user/Dropbox, and define a state directory as /home/user/.dropbox. Set environment variable UID to match your personal Linux numeric user ID.

When you first launch this, use the following command to get the access token:
```
docker logs -f (containerid)
  ...
This computer isn't linked to any Dropbox account...
Please visit https://www.dropbox.com/cli_link_nonce?nonce=f3566e51f010ab5def337e45b319a07a to link this device.
```
Log into Dropbox and click the token URI as shown in the example output above; files will be kept in sync between your host's mounted file contents and your account on the Dropbox service.

A docker-compose.yml example is included here in this source directory.

### Variables

Variable | Default | Description
-------- | ------- | -----------
UID | 1000 | Linux user ID

[![](https://img.shields.io/badge/license-Apache--2.0-red.svg)](https://choosealicense.com/licenses/apache-2.0/ "License badge") [![](https://img.shields.io/badge/code-dropbox%2Fnautilus_dropbox-blue.svg)](https://github.com/dropbox/nautilus-dropbox "Code repo")
