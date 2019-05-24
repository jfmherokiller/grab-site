FROM python:3.7.3-alpine3.9
WORKDIR /app
COPY ./images /app/images
COPY ./libgrabsite /app/libgrabsite
COPY ./grab-site ./gs-dump-urls ./gs-server ./setup.py /app/
RUN apk add --no-cache build-base bash libc6-compat libxml2 libxml2-dev libxslt libxslt-dev libffi-dev re2 re2-dev sqlite sqlite-dev openssl openssl-dev zlib zlib-dev libbz2 readline readline-dev
RUN pip3 install ./
RUN apk del --purge build-base libffi-dev libxslt-dev libxml2-dev re2-dev sqlite-dev openssl-dev zlib-dev readline-dev && \
    rm -R /root/.cache
SHELL ["/bin/bash", "--login", "-c"]
VOLUME ["/data"]
WORKDIR /data
EXPOSE 29000
CMD ["python", "/app/gs-server"]
