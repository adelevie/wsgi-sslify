FROM python:3

ENV workdir /app
RUN mkdir -p $workdir
WORKDIR $workdir

ADD . $workdir/
RUN python setup.py install

RUN pip install pytest
