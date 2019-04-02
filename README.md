# Project

## Setup

### Requirements

In order to use this project you'll need to have the following tools installed in your development box.
* Docker
* Python 3
* npm
* Python editor

Docker

[docker](https://www.docker.com/) is a tool for running containers that will help us launch all the different environments we need for our development process. Search for the proper installation instructions depending on your OS here https://docs.docker.com/install/ and then validate it was installed properly by running

`docker -v`

[docker-compose](https://docs.docker.com/compose/) will be required to launch multiple containers at the same time. Check for the proper installation instractinos here https://docs.docker.com/compose/install/

`docker-compose -v`


Python 3

Python2 will be sunsetting [in 2020](https://www.python.org/dev/peps/pep-0373/#update) so using Python 3 is a must. Python 3 should come pre-installed with every modern operating system. You can validate it is installed by running:

`python3` or `python --version`

Note: The default python interpreter might be set to python 2. This doesn't matter as long as Python 3 is also installed.

For this workshop we won't care about Python 3 minor versions. But if you'd like to install a particupal Python version together with other versions in the same machine then you might consider using [pyenv](https://github.com/pyenv/pyenv).

1. Use [pyenv-installer](https://github.com/pyenv/pyenv-installer) for installing pyenv
1. See which python versions are available: `pyenv install --list`
1. Install python 3. Example: `pyenv install 3.6.3` (3.6.3 or higher)


Also [nodejs](https://nodejs.org/en/) is required for using `eslint` and `jscpd`.

1. Install `nodejs`, this could be archived by using [nvm](https://github.com/creationix/nvm).
1. Install `nodejs` version `7`
1. Use `npm` for installing dependencies: `npm install`

Python IDE / Text editor

You can use any editor that you like. Here are a couple of choices:
* Pycharm
* SublimeText
* Atom
* VS.code

The only real IDE of the list is Pycharm which has very usefull debugging tools. There's a free community edition which is great for Django development at: https://www.jetbrains.com/pycharm/download/#section=linux


### Fork this repository (or not)

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

### Setting's

This project adopts [The 12 factor methodology](https://12factor.net/).
This means the configuration si made by environment variables [(Factor III)](https://12factor.net/config).

## Local setUp

1. Create a new virtualenv with a meaningful name: `pyenv virtualenv 3.6.3 my_virtualenv`
1. Create a `.python-version` file: `echo "my_virtualenv" > .python-version`
1. Install the requirements: `pip install -r requirements/local.txt`

### Development with Docker

1. Build image: `docker-compose build`
1. Start services: `docker-compose up`
1. Migrate database: `docker-compose run --rm django python3 manage.py migrate`
1. Create a super user: `docker-compose run --rm django python3 manage.py createsuperuser`
1. Restart django: `docker-compose restart django`

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


## Project Management

### Remove fork relation

To be able to use the "New branch" button from an issue, you need to go to project's settings and remove the "Fork relationship" with the sample project. If this is not done, the button will be greyed out and read "New branch unavailable".

See [this issue](https://gitlab.com/gitlab-org/gitlab-ce/issues/20704)


## Setup slack integration

You can set up a WebHook notification for your project.
You only need two things:

1. A channel for your project
1. Ensure yourself you haven't reached the WebHook limit of Slack.

### Slack settings

First, go to the [App Directory](https://devartis.slack.com/apps/manage). You will have multiple integrations supported by default.
If Gitlab is not present (It's not at this moment!), go to **Custom Integration** at the left panel.

Then click in the item "Incoming WebHooks" and then in the **Add configuration** button.

Select a channel where you like to receive notifications (Please do not spam us!).
After selecting the channel, configure the integration (Username, icon, etc) and copy the `Webhook URL` you will needed in the next step.

###  Gitlab settings

In your project settings, there a section called "Integrations".
One of them is called "Slack notifications", click on it.

Check the **active** checkbox and configure the integration according to your needs.
Fill the input called `Webhook` with the previously copied `Webhook URL` from slack.

Save the form and test your integration with the button **Test settings and save changes**.

## [Sentry](https://sentry.io/welcome/) integration

> Open-source error tracking that helps developers monitor and fix crashes in real time. Iterate continuously. Boost efficiency. Improve user experience.


### Deployment with Ansible

This project can be deployed with [deploy2-sample](https://gitlab.devartis.com/samples/deploy2-sample).

### Integration

Based in [official integration](https://docs.sentry.io/clients/python/integrations/django/) with Django.

The project's settings `conf/settings/production.py` already adds `'raven.contrib.django.raven_compat',` to the `INSTALLED_APPS`.
Also it adds these lines:

```python
RAVEN_CONFIG = {
    'dsn': env('RAVEN_DSN', default=""),
}
```

So you only have to add the `RAVEN_DNS` to the environment of your application.

### Getting sentry DNS key

devartis has its own version of sentry ([project](https://gitlab.devartis.com/devops/sentry-devartis)).
It can be found at [errors.devartis.com](https://errors.devartis.com).

If you don't have an account, request one to the administrator.
If it is the first project, a new organization must be created. If you already have a project related to this one, you must create another __project__ under the same organization.
Request the administrator for creating a new organization (See below).


At the project settings, there's a section "Client Keys (DNS)".
Copy that URL and set the `RAVEN_DNS` environment variable.

(administrator: it@devartis.com)


### Nginx & Sentry

If a request takes too much time Nginx might end it, but It still could be running in the Gunicorn worker process.
Then, the user will see an error, but Sentry is never notified.
A solution for this is configuring [sentrylogs](https://github.com/mdgart/sentrylogs) application.
It reads nginx logs and reports to Sentry on errors.

Install it with `pip`:

    pip install sentrylogs

Run it with `daemonize` option:

    sentrylogs --daemonize --sentrydsn $RAVEN_DNS

Options:

If your nginx logs are not being saved in the default place (`/var/log/nginx/error.log`), you can specify where they are with `--nginxerrorpath` option.
See [the documentation](https://github.com/mdgart/sentrylogs#how-it-works) for more information
