#!/bin/bash
set -e

if [ "$1" = 'kibana' ]; then
    echo exec gosu kibana "$@"
    exec gosu kibana "$@"
fi

exec "$@"

