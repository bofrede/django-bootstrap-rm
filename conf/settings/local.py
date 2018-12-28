from .base import *

DEBUG = True
TEMPLATE_DEBUG = DEBUG

ALLOWED_HOSTS = ['*']

# variable DATABASE_URL='postgres://dbuser:dbpass@localhost/mydb'
DATABASES = {
    'default': env.db()
}
