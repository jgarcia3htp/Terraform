#!/bin/bash

docker stop nginx_reverse_proxy_c

docker rm nginx_reverse_proxy_c

docker rmi nginx_reverse_proxy
