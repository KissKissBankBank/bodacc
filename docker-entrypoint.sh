#!/bin/sh
set -e

prepare_app() {
    echo "BUNDLE INSTALL"
    bundle install
}

create_database() {
    echo "CREATE DATABASE"
    pg_dump bodacc < structure.sql
}

launch_script() {
    prepare_app
    create_database
    echo "LAUNCH SCAPER"
    DATABASE_URL=postgres://localhost:5432/bodacc ruby main.rb
}

launch_script
