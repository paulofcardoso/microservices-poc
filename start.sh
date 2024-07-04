#!/bin/bash

# Activate virtual environment and start app1
source /usr/src/app/app1_env/bin/activate
uvicorn app1.main:app --host 0.0.0.0 --port 8001 &

# Activate virtual environment and start app2
source /usr/src/app/app2_env/bin/activate
uvicorn app2.main:app --host 0.0.0.0 --port 8002 &

# Activate virtual environment and start gateway
source /usr/src/app/gateway_env/bin/activate
uvicorn gateway.main:app --host 0.0.0.0 --port 8000 &

wait -n