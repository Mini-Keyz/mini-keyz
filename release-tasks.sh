#!/bin/bash

echo "Running release tasks"

if [ "$RUN_MIGRATIONS_DURING_RELEASE" == "true" ]; then
  echo "Running Migrations"
  bundle exec rails db:migrate
fi

if [ "$SEED_DB_DURING_RELEASE" == "true" ]; then
  echo "Seeding DB"
  bundle exec rails db:seed
fi

if [ "$CLEAR_CACHE_DURING_RELEASE" == "true" ]; then
  echo "Clearing Rails Cache"
  bundle exec rails r "Rails.cache.clear"
fi

echo "Done running release-tasks.sh"

echo "Restarting dynos"
heroku restart

echo "Done restarting dynos"