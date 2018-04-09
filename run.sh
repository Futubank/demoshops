#!/usr/bin/env bash
set -e
docker-compose stop
docker-compose build
docker-compose up
