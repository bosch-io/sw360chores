#!/bin/sh

# Copyright Bosch Software Innovations GmbH, 2016.
# Part of the SW360 Portal Project.
#
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html

set -e

COUCHDB_USER_FILE=/run/secrets/COUCHDB_USER
if [ -f "$COUCHDB_USER_FILE" ]; then
    export COUCHDB_USER=$(cat "$COUCHDB_USER_FILE")
fi
COUCHDB_PASSWORD_FILE=/run/secrets/COUCHDB_PASSWORD
if [ -f "$COUCHDB_PASSWORD_FILE" ]; then
    export COUCHDB_PASSWORD=$(cat "$COUCHDB_PASSWORD_FILE")
fi

if [ ! "$COUCHDB_HOST" ]; then
    echo "the environmental variable \$COUCHDB_HOST must be set"
    exit 1
fi

if [ ! "$COUCHDB_USER" ]; then
    echo "the environmental variable \$COUCHDB_USER must be set"
    exit 1
fi

if [ ! "$COUCHDB_PASSWORD" ]; then
    echo "the environmental variable \$COUCHDB_PASSWORD must be set"
    exit 1
fi

COUCHDB_HOST="${COUCHDB_USER}:${COUCHDB_PASSWORD}@${COUCHDB_HOST:-couchdb}";

sed -i -r 's/^url.*=.*/url = http:\/\/'"$COUCHDB_HOST:${COUCHDB_PORT:-5984}"'/' "/couchdb-lucene/conf/couchdb-lucene.ini";
sed -i -r 's/^host.*=.*/host = 0.0.0.0/' "/couchdb-lucene/conf/couchdb-lucene.ini";
exec /couchdb-lucene/bin/run;
exec "$@"
