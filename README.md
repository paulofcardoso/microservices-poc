# Prototype
This is a prototype of a single-container that launches one process for each application, as well as a gateway service. The idea is to follow a microservices approach without having dedicated infrastructure per service. Because each application runs its own process, on its own virtual environment, dependency conflicts between applications is not a problem. Each application runs a FastAPI and an additional gateway service serves forwards requests.

## Run experiment

App 1 has `numpy==1.20.0` in its requirements and App 2 has `numpy==1.24.0`. Both try to run `np.show_runtime()`, which is implemented only in `numpy>=1.24.0`. The goal of the experiment is to show that:
- both apps have their own dependencies and run in their own virtual environments
- ports are irrelevant to the outside user: the gateway service forwards requests to the correct application

Build the container: `make build`

Run the container: `make run`

Once the container is running, try navigating to http://localhost:8000/app1 and http://localhost:8000/app2. You will see that app1 will fail running `np.show_runtime()`, but app2 will succeed, hence showing that they are running on different virtual environments.