"""tfrest URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.10/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url
from django.contrib import admin
from api import TfExamService as tf_service
from django.views.decorators.csrf import csrf_exempt
from api import TfServiceCelry as tf_service_celery

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^api/test/type/example1/operator/(?P<operator>.*)/values/(?P<values>.*)/',
        csrf_exempt(tf_service.as_view())),
    url(r'^api/test/type/celeryexam1/operator/fib/values/(?P<values>.*)/',
        csrf_exempt(tf_service_celery.as_view())),
]
