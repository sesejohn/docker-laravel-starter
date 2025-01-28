#!/bin/bash

set -e

if [ "$APP_ENV" = 'prod' ]; then
    echo "Syncing production apache and php configs"
    rsync -rt /home/docker/prod/apache/ /etc/apache2/sites-available/
    rsync -rt /home/docker/prod/php/ /usr/local/etc/php/
elif [ "$APP_ENV" = 'dev' ]; then
    echo "Syncing dev apache and php configs"
    rsync -rt /home/docker/dev/apache/ /etc/apache2/sites-available/
    rsync -rt /home/docker/dev/php/ /usr/local/etc/php/
fi

exec "$@"
