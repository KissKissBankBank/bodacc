#!/bin/sh
set -e

create_database() {
    if psql -lqt | cut -d \| -f 1 | grep -qw $PGDATABASE; then
      echo "DATABASE ALREADY EXIST"
    else
      echo "CREATE DATABASE"
      createdb $PGDATABASE
      psql $PGDATABASE < structure.sql
    fi
}

launch_script() {
    create_database
    echo "LAUNCH SCRAPER"
    bundle exec ruby main.rb
}

sleep 10
launch_script
