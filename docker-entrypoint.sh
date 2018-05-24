#!/bin/sh
set -e

create_database() {
    if psql -l | grep bodacc_production | wc -l; then
      echo "DATABASE ALREADY EXIST"
    else
      echo "CREATE DATABASE ;"
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
