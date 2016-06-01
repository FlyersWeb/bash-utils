#!/bin/bash
IPADDR=$(wget -qO- http://ipecho.net/plain)
sendmail -oi john@doe.com << EOF
From: some@one.org
To: john@doe.com
Subject: SERVER INFO: IP Address

The server IP Address is $IPADDR

EOF

