#!/usr/bin/env bash
set -e
DIR=$(dirname "$0")
cd ${DIR}/..

echo "Running sonar-scanner"

if [[ -z "$SONARQUBE_TOKEN" ]] || [[ -z "$SONARQUBE_PROJECT_KEY" ]]; then
    echo "No 'SONARQUBE_TOKEN' OR 'SONARQUBE_PROJECT_KEY' variables, skipping..."
else
    npm run sonar-scanner
fi

echo "sonar-scanner OK :)"


