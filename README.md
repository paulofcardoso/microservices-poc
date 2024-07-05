# Prototype
This is a prototype of a single-container that launches one process per application, as well as a gateway service. The idea is to follow a microservices approach without having dedicated infrastructure (or containers) per service. Because each application runs its own process, in its own virtual environment, dependency conflicts between applications is not a problem. Each application runs a FastAPI on a specific port and the gateway service forwards requests.

## Run the experiment

Service 1 has `numpy==1.20.0` in its requirements and Service 2 has `numpy==1.24.0`. Both try to run `np.show_runtime()`, which is a function implemented only in `numpy>=1.24.0`. The goal of the experiment is to show that:
- both services have their own dependencies and run in their own virtual environments;
- ports are irrelevant to the outside user: the gateway service forwards requests to the correct service;

Build the container: `make build`

Run the container: `make run`

Once the container is running, try navigating to http://localhost:8000/service1 and http://localhost:8000/service2. You will see that service1 will fail running `np.show_runtime()`, but service2 will succeed, hence showing that they are running on different virtual environments with different numpy versions.
