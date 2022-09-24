#!/usr/bin/env bash

winpty docker run -it --name zmk zmk && docker cp zmk:/app/firmware/ ./
docker stop zmk
docker rm zmk
