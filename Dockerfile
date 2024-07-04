FROM python:3.9-slim

WORKDIR /usr/src/app

COPY app1/ app1/
COPY app2/ app2/
COPY gateway/ gateway/

RUN pip install virtualenv

# app1
RUN virtualenv /usr/src/app/app1_env
RUN /usr/src/app/app1_env/bin/pip install --no-cache-dir -r app1/requirements.txt

# app2
RUN virtualenv /usr/src/app/app2_env
RUN /usr/src/app/app2_env/bin/pip install --no-cache-dir -r app2/requirements.txt

# gateway
RUN virtualenv /usr/src/app/gateway_env
RUN /usr/src/app/gateway_env/bin/pip install --no-cache-dir -r gateway/requirements.txt

COPY start.sh /usr/src/app/start.sh
RUN chmod +x /usr/src/app/start.sh

EXPOSE 8001 8002 8000

CMD ["./start.sh"]