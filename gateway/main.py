from fastapi import FastAPI, Request
import httpx

app = FastAPI()

@app.api_route("/{path:path}", methods=["GET", "POST", "PUT", "DELETE"])
async def gateway(request: Request, path: str):
    if path.startswith("app1"):
        url = f"http://localhost:8001/{path[5:]}"
    elif path.startswith("app2"):
        url = f"http://localhost:8002/{path[5:]}"
    else:
        return {"message": "Invalid path"}

    client = httpx.AsyncClient()

    response = await client.request(
        method=request.method,
        url=url,
        headers=request.headers.raw,
        content=await request.body(),
    )

    return response.json()
