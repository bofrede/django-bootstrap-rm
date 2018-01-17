#!/usr/bin/env bash
set -e
DIR=$(dirname "$0")
cd ${DIR}/..

echo "py.test flake8"
py.test
echo "py.test OK :)"


