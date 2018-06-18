#!/usr/bin/env bash
set -e
DIR=$(dirname "$0")
cd ${DIR}/..

echo "Running sonar-scanner"

if [[ -z "$SONARQUBE_TOKEN" ]]; then
    echo "No 'SONARQUBE_TOKEN' variable, skipping..."
else
    npm run sonar-scanner
fi

echo "sonar-scanner OK :)"


