import os

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

SECRET_KEY = '*%oe=*$o)$fxb9-$b5o6g-7#0+y2a_$fl3=)+hu8@#&f!f(_2&'
ALLOWED_HOSTS = ['*']  # XXX
DEBUG = True

INSTALLED_APPS = [
    'django.contrib.sessions',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'myshop',
    'futupayments',
]

ROOT_URLCONF = 'myshop.urls'

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'django',
        'USER': 'django',
        'PASSWORD': 'django',
        'HOST': 'mysql',
        'PORT': '3306',
    }
}

TEMPLATES = [{
    'BACKEND': 'django.template.backends.django.DjangoTemplates',
    'DIRS': [
        os.path.join(BASE_DIR, 'templates'),
    ],
    'APP_DIRS': True,
    'OPTIONS': {
        'context_processors': [
            'django.template.context_processors.debug',
            'django.template.context_processors.request',
            'django.contrib.auth.context_processors.auth',
            'django.contrib.messages.context_processors.messages',
        ],
    }
}]

MIDDLEWARE = [
    'django.contrib.sessions.middleware.SessionMiddleware',
]

LANGUAGE_CODE = 'ru-ru'
TIME_ZONE = 'Europe/Moscow'
USE_I18N = True
USE_L10N = True
USE_TZ = True

MAX_POOL_SIZE = 50

STATIC_URL = '/static/'

FUTUPAYMENTS_MERCHANT_ID = 'demoshops'
FUTUPAYMENTS_SECRET_KEY = 'F87939421C1826BF920927395C61BA2C'
FUTUPAYMENTS_RECIEPTS = True
FUTUPAYMENTS_SUCCESS_URL = '/django/futupayments/success/'
FUTUPAYMENTS_FAIL_URL = '/django/futupayments/fail/'
FUTUPAYMENTS_HOST = 'https://dev.futubank.com/'
FUTUPAYMENTS_TEST_MODE = True
