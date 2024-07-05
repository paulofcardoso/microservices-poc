#!/bin/bash

# Activate virtual environment and start service1
source /usr/src/app/service1_env/bin/activate
uvicorn service1.main:app --host 0.0.0.0 --port 8001 &

# Activate virtual environment and start service2
source /usr/src/app/service2_env/bin/activate
uvicorn service2.main:app --host 0.0.0.0 --port 8002 &

# Activate virtual environment and start gateway
source /usr/src/app/gateway_env/bin/activate
uvicorn gateway.main:app --host 0.0.0.0 --port 8000 &

wait -n