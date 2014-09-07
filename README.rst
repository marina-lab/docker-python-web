=================
docker-python-web
=================

Dockerized Python Web Server base image, using `gevented`_ `uwsgi`_.

.._gevented: http://www.gevent.org/
.. _uwsgi: http://uwsgi-docs.readthedocs.org/en/latest/

gevent workers are opt-in: it is left up to the application layer to turn on
gevent with `uwsgi --gevent`.

