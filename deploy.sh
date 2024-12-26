#!/bin/bash

docker build -t nginx_reverse_proxy -f Dockerfile_nginx .

docker run -d --name nginx_reverse_proxy_c --network=host nginx_reverse_proxy
