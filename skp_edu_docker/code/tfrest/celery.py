from __future__ import absolute_import, unicode_literals
import os
from celery import Celery
import logging
from django.conf import settings

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'tfrest.settings')

app = Celery('tfrest')
app.config_from_object('django.conf:settings')
app.autodiscover_tasks(lambda: settings.INSTALLED_APPS)

CELERYD_HIJACK_ROOT_LOGGER = False
