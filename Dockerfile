FROM alpine:3.16 as python-install

ENV PYTHON_VERSION 3.8.14

RUN apk add wget build-base make zlib-dev libffi-dev openssl-dev musl-dev

WORKDIR /opt
RUN wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz
RUN tar xzf Python-${PYTHON_VERSION}.tgz

WORKDIR /opt/Python-${PYTHON_VERSION} 
RUN ./configure --prefix=/usr --enable-optimizations --with-ensurepip=install
RUN make install
RUN rm /opt/Python-${PYTHON_VERSION}.tgz /opt/Python-${PYTHON_VERSION} -rf

FROM python-install as app

ADD . /app
WORKDIR /app
RUN pip3 install -r requirements.txt
ENTRYPOINT [ "python3" ]
CMD ["main.py"]