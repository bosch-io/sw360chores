#!/bin/bash
# Copyright Bosch Software Innovations GmbH, 2019.
# Part of the SW360 Portal Project.
#
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html

envsubst < /etc/sw360/couchdb.properties.template > /etc/sw360/couchdb.properties
envsubst < /etc/sw360/sw360.properties.template > /etc/sw360/sw360.properties

exec catalina.sh run