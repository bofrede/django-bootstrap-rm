# Django Boostrapping in 2019

We have been working with Django for many years and we discovered we were always repeating the same things at the beginning of each project. Pycodestyle checks, unit tests, automated deployment, we where doing all of them over and over again and occasionally we were missing important things that would make our lives easier.

That's why we decided to create and maintain template repository with all the required tools to bootstrap a Django project. It has become very valuable for our company and that's why we want to share it with the community. The project is now open source and we will review all it does in this talk.


## Requirements

In order to use this project you'll need to have the following tools installed in your development box.

* Docker & Docker Compose
* Python 3
* npm
* Python editor
* Bitbucket free account
* Heroku free account

### Docker

[docker](https://www.docker.com/) is a tool for running containers that will help us launch all the different environments we need for our development process. Search for the proper installation instructions depending on your OS here https://docs.docker.com/install/ and then validate it was installed properly by running

`docker -v`

[docker-compose](https://docs.docker.com/compose/) will be required to launch multiple containers at the same time. Check for the proper installation instructions here https://docs.docker.com/compose/install/

`docker-compose -v`


### Python 3

Python2 will be sunsetting [in 2020](https://www.python.org/dev/peps/pep-0373/#update) so using Python 3 is a must. Python 3 should come pre-installed with every modern operating system. You can validate it is installed by running:

`python3` or `python --version`

Note: The default python interpreter might be set to python 2. This doesn't matter as long as Python 3 is also installed.

For this workshop we won't care about Python 3 minor versions. But if you'd like to install a particupal Python version together with other versions in the same machine then you might consider using [pyenv](https://github.com/pyenv/pyenv).

1. Use [pyenv-installer](https://github.com/pyenv/pyenv-installer) for installing pyenv
1. See which python versions are available: `pyenv install --list`
1. Install python 3. Example: `pyenv install 3.6.3` (3.6.3 or higher)

### npm 

Also [nodejs](https://nodejs.org/en/) is required for using `eslint` and `jscpd`.

1. Install `nodejs`, this could be archived by using [nvm](https://github.com/creationix/nvm).
1. Install `nodejs` version `7` or later
1. Use `npm` for installing dependencies: `npm install`

Python IDE / Text editor

You can use any editor that you like. Here are a couple of choices:
* Pycharm
* VS.code
* SublimeText
* Atom

The only real IDE of the list is Pycharm which has very usefull debugging tools. There's a free community edition which is great for Django development at: https://www.jetbrains.com/pycharm/download/#section=linux


## Fork this repository (or not)

First thing we want to do is to copy all files included here to your own project.

A way to do this is to fork the repository. For this you need to click on the + sign on the left menu and then `Fork this repository`. Unfortunately Bitbucket doesn't let us [detach the fork relationship](https://bitbucket.org/site/master/issues/13645/detach-fork-from-upstream-repository?_ga=2.124476746.1157251317.1554214266-698969354.1525956740) so your repository will always be related to this original repository.

If you want to avoid this you can clone the project and change the `origin` remote:

```
$ git clone git clone git@bitbucket.org:fjaramendi/django-bootstrap.git
$ git remote add new git@bitbucket.org:fjaramendi/django-bootstrap-remove.git
$ git remote remove origin
$ git remote -v
$ git push -u origin master
```

And if you want to remove this project's history and start with only one inital commit you'll need to do this before instead:

```
$ rm -rf .git
$ git init
$ git add .
$ git commit -m "Removed history, due to sensitive data"
$ git remote add origin git@bitbucket.org:fjaramendi/django-bootstrap-remove.git
$ git push -u --force origin master
```

Login to your Bitbucket account and make sure your new repository is there as intended.


## Dependency management and Virtual environment - Pipenv!

[Pipenv](https://pipenv.readthedocs.io/en/latest/) "automatically creates and manages a virtualenv for your projects, as well as adds/removes packages from your Pipfile as you install/uninstall packages. It also generates the ever-important Pipfile.lock, which is used to produce deterministic builds."

Pipenv is the official package management tool [recommended by Python](https://packaging.python.org/tutorials/managing-dependencies/#managing-dependencies).

Python2 is still the default Python installation.

```
$ python
$ pipenv --three
$ pipenv shell
$ python
(ctrl+d)
$ pipenv --rm
```

Now let's install our project requirements.

```
$ pipenv install --dev
$ pipenv shell
$ python 
>>> import django
(ctrl+d)
```

## Project structure

### Setting's

We created multiple settings files for the different environments. Take a look at the settings directory.

Also, this project adopts [The 12 factor methodology](https://12factor.net/).
This means the configuration is made by environment variables [(Factor III)](https://12factor.net/config) instead of hardcoding passwords in versioned files.

To start we'll need to copy the two sample files:

```
cp conf/settings/local.example.py conf/settings/local.py 
cp .env.sample .env
```

## Docker intro

"A Docker container image is a lightweight, standalone, executable package of software that includes everything needed to run an application: code, runtime, system tools, system libraries and settings."
We will use Docker to run external dependencies of our project (like a Database or a cache) and also to debug Pipelines.

To fire a python container run:

`docker run -it --entrypoint=/bin/bash python:3.6.0`

And you can run a DB container by running:

`docker run -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=db mysql`
`mysql -h127.0.0.1 -proot -uroot`

There’s an easier way to run both containers every time we are working on the project and that’s with the [Docker Compose](https://docs.docker.com/compose/) tool.

`docker-compose.yml` file comes preconfigured with a PostgreSQL database and a Python container that runs your Django app.

## Setup a development Database

If we try to launch Django application we'll get an error since the db is not yet configured:

`$ python manage.py runserver_plus`

If you didn't copy the .env.sample file you'll get a `Set the DATABASE_URL environment variable` error. If you did, you'll most likely get a `Connection refused` since we don't have any DB engine running yet.

```
$ docker-compose up db
$ python manage.py runserver_plus (ctrl+c)
```

Now that we have a DB server we can run migrations:

```
$ python manage.py migrate
```

You should have a running Django project to this point.

## Development with Docker

1. Build image: `docker-compose build`
1. Start services: `docker-compose up`
1. Migrate database: `docker-compose run --rm django python3 manage.py migrate`
1. Create a super user: `docker-compose run --rm django python3 manage.py createsuperuser`
1. Restart django: `docker-compose restart django`

## Git hooks

Git hooks are scripts that Git executes before or after specific events such as: commit, push, and receive. Git hooks are a built-in feature, so all we need to do is to create a shell script.

```
ls -la .git/hooks
cp scripts/pre-push.sh .git/hooks/pre-push
cp scripts/commit-msg.sh .git/hooks/commit-msg
```

The hooks configured for the project are:

* [Flake8](http://flake8.pycqa.org/en/latest/index.html): `scripts/flake8.sh`
* [Pylint](https://pylint.readthedocs.io/en/latest/): `scripts/pylint.sh`
* [Jscpd](https://github.com/kucherenko/jscpd): `scripts/jscpd.sh`
* [Eslint](https://eslint.org/): `scripts/eslint.sh`

Since some linters require [nodejs](https://nodejs.org/en/), please install nodejs and then run `npm install`.

### Test the hooks

Modify a file with a PEP8 violation

```
git commit
git push
```
Fix

```
git commit --amend
git push
```

## Pipelines (Continuous Integration)

### Intro

### Enable bitbucket pipelines

Bitbucket now has Pipeline runners for free. Keep in mind you only have 50h a month.
Go to the Pilines section of your repository in Bitbucket and click Enable
Check it runs for the first time. All steps should be green!

Now let's look at the `bitbucket-pipelines.yml` file

## How to debug a pipeline

It's very likely that you'll want to modify pipelines over time or that eventually something will break. It's important to be able to debug things locally so that you don't have to push new commits to test runs.

To start a Python container
```
$ docker run -it --volume=/home/fara/code/djangocon/django-bootstrap:/django-bootstrap --workdir="/django-bootstrap" --memory=4g --memory-swap=4g --memory-swappiness=0 --entrypoint=/bin/bash python:3.6.0
```

## Deployment (Continuous Delivery)

### Heroku

For simplicity we will use Heroku as our application server.

Login in to Heroku and click New-> Create new app

Install Heroku cli following the instructions for your OS at https://devcenter.heroku.com/articles/heroku-cli

Heroku looks for a `Procfile` in order to understand how to run your app. Open it.

The easiest way to deploy to Heroku would be to push to it's remote:
```
heroku login
heroku git:remote -a django-boostrap
git push heroku master
```

But we want to configure a Pipeline to do this so that we can make it depend on succesfull build and also centralize deployment in our build server instead of one developer's computer.

First we need to generate and API token:

```
heroku login
heroku authorizations:create -d "getting started token"
```

Set the token and application name as a variables in Bitbucket. Settings -> Pipelines -> Repository Variables

Test deploy. It will fail
Open Heroku logs

We need to set all production environment secret variables and
We need to setup Whitenoise https://devcenter.heroku.com/articles/django-assets

#### Secret env variables

Go to Heroku -> Your app -> settings -> config vars and add the following entries

DJANGO_SETTINGS_MODULE, DJANGO_SECRET_KEY, ALLOWED_HOST

```
$ pipenv install whitenoise
$ git add Pipfile Pipfile.lock
$ git commit
```

add `'whitenoise.middleware.WhiteNoiseMiddleware',` to MIDDLEWARE_CLASSES in settings.py

#### Add a PostgreSQL database and configure the connection credentials

Go to Resources - Add ons
Find Heroku Postgres and add the free instance
You should see the DATABASE_URL var added automatically

#### Test the pipeline

```
docker run -it --volume=/home/fara/code/djangocon/django-bootstrap-remove:/app --workdir="/app" --memory=2g --entrypoint=/bin/sh ruby:2.4-alpine3.7
```

## Monitoring your production app

### Sentry

[Sentry](https://sentry.io/) Is an open-source error tracking platform that helps developers monitor and fix crashes in real time.
It's very handy to track errors thrown in production since it sends email digests, groups errors by type and gathers trace info.

There's a very easy way to start tracking your errors with Django and that's thanks to the [Raven client](https://github.com/getsentry/raven-python)
`production.py` settings already has raven configured, so all you'll need to do is to:

* Start a new Sentry project and get the DSN key
* Set `RAVEN_DSN` env variable in the production environment

### NewRelic

NewRelic is a great [APM](https://en.wikipedia.org/wiki/Application_performance_management) tool that's very easy to plug and will become very handy when you need to profile or monitor the performance of your application.

To configure it in Heroku is as simple as enabling the NewRelic agent addon.
Installing the add-on automatically creates a private New Relic account and configures access for Heroku hosts. New Relic will begin monitoring application performance, end user experience, and host performance collected after the add-on is installed

## Credits

Developed by [devartis](https://www.devartis.com)
