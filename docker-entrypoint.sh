#!/bin/sh
set -e

create_database() {
    echo "CREATE DATABASE"
    createdb $PGDATABASE
    psql < structure.sql
}

launch_script() {
    create_database
    echo "LAUNCH SCRAPER"
    bundle exec ruby main.rb
}

sleep 10
launch_script
