# Project

## Setup

### Requirements

This projects requires python 3.6.
Python 3 can be installed with [pyenv](https://github.com/pyenv/pyenv).

1) Use [pyenv-installer](https://github.com/pyenv/pyenv-installer) for installing pyenv
3) See which python versions are available: `pyenv install --list`
2) Install python 3. Example: `pyenv install 3.6.3` (3.6.3 or higher)

### Setting's

This project adopts [The 12 factor methodology](https://12factor.net/).
This means the configuration si made by environment variables [(Factor III)](https://12factor.net/config).

## Local setUp

1. Create a new virtualenv with a meaningful name: `pyenv virtualenv 3.6.3 my_virtualenv`
1. Create a `.python-version` file: `echo "my_virtualenv" > .python-version`
1. Install the requirements: `pip install -r requirements/local.txt`
1. Set the settings variable: `export DJANGO_SETTINGS_MODULE=conf.settings.local`
1. Copy the `.env` file: cp conf/settings/.env.sample conf/settings/.env
1. Setup the sqlite3 database: `./manage.py migrate`
1. Create a super user: `./manage.py createsuperuser`

## Git hooks

* Install [git-hooks](https://github.com/git-hooks/git-hooks/).
* Install git hooks: `git hooks install`


## Tips:

## Run server

* `./manage.py runserver`

## Run shell

* `./manage.py shell`

## Run tests

* `python manage.py test`

## Run Lint/Style/CPD

Some linters require [nodejs](https://nodejs.org/en/).
Please install nodejs and then run `npm install`.


* [Flake8](http://flake8.pycqa.org/en/latest/index.html): `scripts/flake8.sh`
* [Pylint](https://pylint.readthedocs.io/en/latest/): `scripts/pylint.sh`
* [Jscpd](https://github.com/kucherenko/jscpd): `scripts/jscpd.sh`
* [Eslint](https://eslint.org/): `scripts/eslint.sh`

## Pycharm IDE

* Config virtualenv created before as the virtualenv of the project (settings -> python interpreter)
* enable django support: settings -> django 
  * django project root: /home/diego/dev/projects/python/project_name
  * settings: conf/settings/local.py
  * manage script: manage.py
* mark directory Templates as "Templates folder" (right-click over directory in the "Project view")


## Services

TODO


## Project Management

### Remove fork relation

To be able to use the "New branch" button from an issue, you need to go to project's settings and remove the "Fork relationship" with the sample project. If this is not done, the button will be greyed out and read "New branch unavailable".

See [this issue](https://gitlab.com/gitlab-org/gitlab-ce/issues/20704)

### Copy milestones, issues and labels

We have a template for software development projects (technology agnostic) that specifies some tasks that we need to do in all the projects and labels to categorize issues.

To copy this structure you have to:

1. Install [gitlab-copy](https://github.com/gotsunami/gitlab-copy#download)
1. Get a [Gitlab access token](https://gitlab.devartis.com/profile/personal_access_tokens) and put it on [.gitlab-copy.yml](/.gitlab-copy.yml)
1. Run gitlab-copy: `gitlab-copy -y .gitlab-copy.yml`

### Setup slack integration

TODO

### Sentry integration

TODO
