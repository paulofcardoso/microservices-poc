FROM python:3.9-slim

WORKDIR /usr/src/app

COPY service1/ service1/
COPY service2/ service2/
COPY gateway/ gateway/

RUN pip install virtualenv

# service1
RUN virtualenv /usr/src/app/service1_env
RUN /usr/src/app/service1_env/bin/pip install --no-cache-dir -r service1/requirements.txt

# service2
RUN virtualenv /usr/src/app/service2_env
RUN /usr/src/app/service2_env/bin/pip install --no-cache-dir -r service2/requirements.txt

# gateway
RUN virtualenv /usr/src/app/gateway_env
RUN /usr/src/app/gateway_env/bin/pip install --no-cache-dir -r gateway/requirements.txt

COPY start.sh /usr/src/app/start.sh
RUN chmod +x /usr/src/app/start.sh

EXPOSE 8001 8002 8000

CMD ["./start.sh"]