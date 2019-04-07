#!/usr/bin/env bash
set -e
DIR=$(dirname "$0")
cd ${DIR}/../..

echo "Running flake8"
pipenv run flake8 --config=scripts/.flake8
echo "flake8 OK :)"

echo "Running pylint"
pipenv run pylint --rcfile=scripts/.pylintrc project
echo "pylint OK :)"

echo "Running py.test"
pipenv run pytest -c scripts/pytest.ini --cov --cov-config scripts/.coveragerc --junitxml=../test-results/xunit-result-master.xml;
echo "py.test OK :)"

echo "Running eslint"
npx eslint --config scripts/.eslint.js project
echo "eslint OK :)"

echo "Running jscpd"
npm run jscpd --config scripts/.cpd.yaml
echo "jscpd OK :)"
