## weewx

Weather station software WeeWX

This includes WeeGreen skin; see the [live site](http://wx.ci.net) for
an example.

First create secrets:

    echo pw > ~/.docker/secrets/weewx-db-password
    echo pw > ~/.docker/secrets/weewx-wunderground-password
    echo apikey > ~/.docker/secrets/weewx-wunderground-apikey
    cp rsync-sshkey.pem > ~/.docker/secrets/weewx-rsync-sshkey

Then deploy this service, see the example docker-compose.yml (won't
run in swarm if you need a devices section). Available
environment variables are:

| Variable | Default value | Description |
| -------- | ------------- | ----------- |
| ALTITUDE | "100, foot" | elevation of station |
| LATITUDE | 50.00 | coordinates |
| LONGITUDE | -80.00 | coordinates  |
| DB_BINDING_SUFFIX | mysql | suffix for db binding stanzas |
| DB_DRIVER | weedb.mysql | database driver |
| DB_HOST | db | hostname of db |
| DB_NAME | weewx_a | name of main archive database |
| DB_NAME_FORECAST | weewx_f | name of forecast database |
| DB_USER | weewx | username for db |
| HTML_ROOT | /var/www/weewx | tmp directory for generating html/png images |
| LOCATION | "Anytown, USA" | location to display in banner |
| LOGGING_INTERVAL | 300 | sampling interval |
| RAIN_YEAR_START | 7 | month to start collecting annual rain data |
| RAPIDFIRE | True | enable Weather Underground realtime updates |
| RSYNC_HOST | web01 | rsync destination host |
| RSYNC_DEST | /var/www/htdocs/wx | rsync destination path |
| RSYNC_USER | wx | rsync username |
| SKIN | standard | skin to enable |
| STATION_ID | unset | Weather Underground station ID |
| SYSLOG_DEST | /var/log/messages | Syslog file or TCP dest (@@host:port) |
| TZ | US/Eastern | Local timezone |
| TZ_CODE | 10 | Davis VantagePro timezone code see [index](https://www.manualslib.com/manual/586601/Davis-Vantage-Pro.html?page=39) |
| WEEK_START | 6 | day of week to start weekly data (0 = Mon) |
| XTIDE_LOCATION | unset | xtide setting, see [index](http://tides.mobilegeographics.com/) |

### Notes

This can't run in swarm because it needs to attach the
weather stations as devices, and docker-compose doesn't support 
"external" secrets outside a swarm so currently they have to
be stored as plain-text files.

Output logging from weewx is a bit of a mess: when running
in foreground, a lot of verbose clutter appears on stdout; the
real logs go to syslog and there's no configuration method to
send these elsewhere (like stdout to conform to Docker's logging
standard). So the SYSLOG_DEST environment variable provided here
can provide a way to send proper logging (via the rsyslogd
process included in this image) to a central syslog service.


