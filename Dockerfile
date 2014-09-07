FROM marina/python:2.7.8_r1
MAINTAINER sprin

# This app will always use uwsgi/gevent, so we add them on top of the Python
# layer, but before packages for the app itself in requirements.txt are
# installed.
RUN pip install gevent==1.0.1 uWSGI==2.0.6
