FROM marina/python:2.7.9_r2
MAINTAINER sprin

# It is assumed our Python web apps are using uwsgi/gevent, so we add them on
# top of the Python layer to create new image.
COPY build_profile.ini /usr/src/uwsgi/buildconf/
RUN set -x \
    && pip install gevent==1.0.1 \
    && curl -sL "http://projects.unbit.it/downloads/uwsgi-2.0.10.tar.gz" \
        | tar -xzC /usr/src/uwsgi --strip-components=1 \
    && mkdir /usr/lib/uwsgi \
    && cd /usr/src/uwsgi \
    && python uwsgiconfig.py --build build_profile \
    && python uwsgiconfig.py --plugin plugins/python build_profile \
    && python uwsgiconfig.py --plugin plugins/gevent build_profile \
    && python uwsgiconfig.py --plugin plugins/transformation_gzip build_profile \
    && python uwsgiconfig.py --plugin plugins/transformation_chunked build_profile \
    && cp uwsgi /usr/local/bin \
    && rm -rf /usr/src/uwsgi

# Add mime.types
COPY mime.types /etc/mime.types
