# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory
WORKDIR /usr/src/app

# Copy application directories
COPY app1/ app1/
COPY app2/ app2/
COPY gateway/ gateway/

# Install virtualenv
RUN pip install virtualenv

# Create virtual environments for each app
RUN virtualenv /usr/src/app/app1_env
RUN /usr/src/app/app1_env/bin/pip install --no-cache-dir -r app1/requirements.txt

RUN virtualenv /usr/src/app/app2_env
RUN /usr/src/app/app2_env/bin/pip install --no-cache-dir -r app2/requirements.txt

RUN virtualenv /usr/src/app/gateway_env
RUN /usr/src/app/gateway_env/bin/pip install --no-cache-dir -r gateway/requirements.txt

# Copy the script to start all FastAPI applications
COPY start.sh /usr/src/app/start.sh
RUN chmod +x /usr/src/app/start.sh

# Expose ports
EXPOSE 8001 8002 8000

# Command to run the script
CMD ["./start.sh"]