FROM marina/python:2.7.9_r1
MAINTAINER sprin

# This app will always use uwsgi/gevent, so we add them on top of the Python
# layer, but before packages for the app itself in requirements.txt are
# installed.

# We build gevent in a separate layer until it can compile consistently
# without error.
RUN set -x \
    && mkdir -p /usr/src/gevent \
    && curl -sL "https://github.com/gevent/gevent/releases/download/1.0.1/gevent-1.0.1.tar.gz" \
        | tar -xzC /usr/src/gevent --strip-components=1 \
    && cd /usr/src/gevent \
    && python setup.py install \
    && mkdir -p /usr/src/uwsgi \
    && rm -rf /usr/src/gevent \
    && curl -sL "http://projects.unbit.it/downloads/uwsgi-2.0.9.tar.gz" \
        | tar -xzC /usr/src/uwsgi --strip-components=1 \
    && cd /usr/src/uwsgi \
    && python uwsgiconfig.py --build core \
    && python uwsgiconfig.py --plugin plugins/python core \
    && python uwsgiconfig.py --plugin plugins/gevent core \
    && python uwsgiconfig.py --plugin plugins/transformation_gzip core \
    && rm -rf /usr/src/uwsgi
