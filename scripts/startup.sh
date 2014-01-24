#!/bin/bash

_HOSTNAME=`hostname -f`

echo -e "[vhosts]\n$_HOSTNAME:5984 = /registry/_design/app/_rewrite" >> /usr/local/etc/couchdb/local.d/npmjs-vhost.ini
echo -e "127.0.0.1\t$_HOSTNAME" >> /etc/hosts
cat /opt/npmjs/kappa.json.default|sed -e "s/\${hostname}/$_HOSTNAME/" > /opt/npmjs/kappa.json
couchdb -b; hapi -c /opt/npmjs/kappa.json & tail -f /usr/local/var/log/couchdb/couch.log
