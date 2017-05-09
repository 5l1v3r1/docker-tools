## mt-daapd

This is Ron Pedde's [Firefly Media
server](https://en.wikipedia.org/wiki/Firefly_Media_Server) which implements the
Digital Audio Access Protocol for serving MP3 and other audio media formats
from a directory mounted to this container onto a LAN.

Devices such as Roku, Sonos and other brands of audio players or
applications such as the Amarok music play for Linux will be able to connect
to this service using mDNS/DNS-SD (Avahi).

Requires --net=host in order to support mDNS. See the docker-compose.yml
file for an example. To start, invoke this command:

    docker-compuse up -d

