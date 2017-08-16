#! /bin/sh
APACHEDIR=/var/www/localhost
APACHECONF=/etc/apache2/conf.d
PHPINI=/etc/php5/php.ini
DB_PASS=`cat /run/secrets/$DB_PASSWD_SECRET`

if [ ! -f /etc/timezone ] && [ ! -z "$TZ" ]; then
  # At first startup, set timezone
  apk add --update tzdata
  cp /usr/share/zoneinfo/$TZ /etc/localtime
  echo $TZ >/etc/timezone
fi

cd $APACHEDIR/htdocs/squirrelmail
for file in config/config.php plugins/sasql/sasql_conf.php; do
  sed -e "s:{{ ATTACHMENT_DIR }}:$ATTACHMENT_DIR:" \
      -e "s/{{ BANNER_HEIGHT }}/$BANNER_HEIGHT/" \
      -e "s:{{ BANNER_IMG }}:$BANNER_IMG:" \
      -e "s/{{ BANNER_WIDTH }}/$BANNER_WIDTH/" \
      -e "s:{{ DATA_DIR }}:$DATA_DIR:" \
      -e "s/{{ DB_HOST }}/$DB_HOST/" \
      -e "s/{{ DB_NAME }}/$DB_NAME/" \
      -e "s/{{ DB_NAME_ADDR }}/$DB_NAME_ADDR/" \
      -e "s/{{ DB_PASS }}/$DB_PASS/" \
      -e "s/{{ DB_USER }}/$DB_USER/" \
      -e "s/{{ DOMAIN }}/$DOMAIN/" \
      -e "s/{{ IMAP_PORT }}/$IMAP_PORT/" \
      -e "s/{{ IMAP_SERVER }}/$IMAP_SERVER/" \
      -e "s/{{ IMAP_TLS }}/$IMAP_TLS/" \
      -e "s/{{ MESSAGE_MOTD }}/$MESSAGE_MOTD/" \
      -e "s/{{ ORGANIZATION }}/$ORGANIZATION/" \
      -e "s/{{ SMTP_PORT }}/$SMTP_PORT/" \
      -e "s/{{ SMTP_SMARTHOST }}/$SMTP_SMARTHOST/" \
      -e "s/{{ SMTP_TLS }}/$SMTP_TLS/" \
      ${file}.j2 > ${file}
done
sed -i \
    -e "s+^date.timezone =.*+date.timezone = $TZ+" \
    -e "s+^;include_path = \".:/php.*+include_path = \".:/usr/local/lib/php:/usr/share/pear\"+" \
    -e "s/^post_max_size =.*/post_max_size = $PHP_POST_MAX_SIZE/" \
    -e "s/^upload_max_filesize =.*/upload_max_filesize = $PHP_UPLOAD_MAX_FILESIZE/" \
    $PHPINI

cat >$APACHECONF/squirrelmail.conf <<EOF
LoadModule actions_module modules/mod_actions.so
<Directory "$APACHEDIR/htdocs/squirrelmail">
    Options MultiViews
    AllowOverride None
</Directory>
EOF

mkdir -p /run/apache2
chown apache $ATTACHMENT_DIR $DATA_DIR

while [ 1 == 1 ]; do
  /usr/sbin/httpd -DFOREGROUND
  sleep 5
done
