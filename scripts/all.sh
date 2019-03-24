#!/usr/bin/env bash
set -e
DIR=$(dirname "$0")
cd ${DIR}/..

echo "Running flake8"
pipenv run flake8
echo "flake8 OK :)"

echo "Running pylint"
pipenv run pylint --load-plugins pylint_django project/
echo "pylint OK :)"

echo "Running py.test"
pipenv run py.test -v $@
echo "py.test OK :)"

echo "Running eslint"
npm run eslint
echo "eslint OK :)"

echo "Running jscpd"
npm run jscpd
echo "jscpd OK :)"
