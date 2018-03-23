#!/bin/sh
set -e

create_database() {
    echo "CREATE DATABASE"
    psql bodacc < structure.sql
}

launch_script() {
    create_database
    echo "LAUNCH SCRAPER"
    ruby main.rb
}

launch_script
