# WSGI-SSLify

![](ssl-all-the-things.jpg)

(Yes, I know "TLS" would be more accurate. Deal with it.)

WSGI middleware to redirect all incoming HTTP requests to HTTPS. Inspired
by [djangosecure](http://django-secure.readthedocs.org/en/v0.1.2/) and
[flask-sslify](https://github.com/kennethreitz/flask-sslify), except
for raw WSGI apps.

Why?

I was using [static](https://github.com/lukearno/static), and I wanted
to force SSL. It was hard. So I made it easy:

```python
app = sslify(static.Cling('content/'))
```

## Usage

It really is that easy; just wrap your app with `sslify`:

```python
from somewhere import my_wsgi_app
from wsgi_sslify import sslify

app = sslify(my_wsgi_app)
```

## Options

You can pass some keyword arguments to `sslify` to control its behavior:

* `hsts` (default: `True`) - set a `Strict-Transport-Security` header, which
  instructs browsers to always use HTTPS.
  [See OWASP for more details on HSTS](https://www.owasp.org/index.php/HTTP_Strict_Transport_Security).

* `max_age` (default: one year) - length, in seconds, for browsers to force
  HTTPS.

* `subdomains` (default: `False`) - force HTTPS for all subdomains, too.

* `permanent` (default: `True`) - issue a permanent (HTTP 301) redirect.
  If False, issue a temporary (HTTP 302) redirect.

* `proxy_header` (default: `X-Forwarded-Proto`) - for services behind a proxy,
  this is the name of the header that contains the *real* request scheme.

* `preload` (default: 'False') - adds the "preload" directive.

## Contributing

Testing: use [py.test](http://pytest.org).

### Docker setup

You can develop and test this code within a Docker container.

To build the image:

```
docker build -t wsgi-sslify .
```

To run tests:

```
docker run -it --rm -v $(pwd):/app/ wsgi-sslify pytest
```

Contributing: send me pull requests.
