#!/usr/bin/env bash
set -e
DIR=$(dirname "$0")
cd ${DIR}/..

echo "Running flake8"
npm run jscpd
echo "flake8 OK :)"


