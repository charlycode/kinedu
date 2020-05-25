#!/bin/bash
set -e

dir="/app"

if [[ -d "$dir/config" ]];
then

    # Remove a potentially pre-existing server.pid for Rails.
    rm -f /app/tmp/pids/server.pid
    bundle install
    #bundle exec rake db:migrate

    if [[ $? -ne 0 ]]; then
      echo
      echo "== Failed to migrate. Running setup first."
      echo
      #bundle exec rake db:setup
    fi
else
    cd $dir \
    && bundle install \
    && bundle exec rails new . --force --no-deps --database=mysql \
    && bundle exec spring binstub --all
    [[ $? -ne 0 ]] && echo "Error to execute rails new" && exit 1
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"