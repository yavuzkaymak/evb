#!/usr/bin/env bash

set -e

cd "${0/*}"

start(){
    docker compose -f generate-indexer-certs.yml run --rm generator
    docker compose up -d  --remove-orphans
}

stop(){
    docker compose down
}

$@