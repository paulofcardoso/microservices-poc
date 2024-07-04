# Prototype
This is a prototype of a single-container that launches one process per application, as well as a gateway service. The idea is to follow a microservices approach without having dedicated infrastructure (or containers) per service. Because each application runs its own process, with its own virtual environment, dependency conflicts between applications is not a problem. Each application runs a FastAPI on a specific port and the gateway service forwards requests.

## Run the experiment

App 1 has `numpy==1.20.0` in its requirements and App 2 has `numpy==1.24.0`. Both try to run `np.show_runtime()`, which is a function implemented only in `numpy>=1.24.0`. The goal of the experiment is to show that:
- both apps have their own dependencies and run in their own virtual environments;
- ports are irrelevant to the outside user: the gateway service forwards requests to the correct application;

Build the container: `make build`

Run the container: `make run`

Once the container is running, try navigating to http://localhost:8000/app1 and http://localhost:8000/app2. You will see that app1 will fail running `np.show_runtime()`, but app2 will succeed, hence showing that they are running on different virtual environments.

## Comments
- No dependency conflicts between applications;
- Applications are standalone and have their own API. If one day we want to move them to their own container / infrastructure, it will be a piece of cake;
- Moving existing projects from the current approach in ai-services to this one does not require specific knowledge about the project (we only need to follow the routes in ai-services and replicate them in the gateway service);
- We could have a single repo, with one branch per project. Releases would be controlled with merges to master;

Need to investigate:
- What happens when a process fails? Maybe we need another process for health checking and to restart failed processes? Or just break everything so that the orchestrator fires everything up again?;
- Common libraries (ex: ai-common) might be tricky without a package index;
- What about logging? There will be multiple processes running... How to manage logs?;
- What about websockets?