from fastapi import FastAPI
import numpy as np

app = FastAPI()

@app.get("/")
def read_root():
    success = False
    try:
        _ = np.show_runtime()  # requires numpy>=1.24.0
        success = True
    except AttributeError:
        print("AttributeError")
    return {"message": f"Hello from service 2! Success: {success} with numpy "
                       f"version {np.__version__}"}
