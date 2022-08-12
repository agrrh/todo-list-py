from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware

from starlette.requests import Request
from starlette.responses import Response

from models.todo_task import TodoTask

from redis_om import get_redis_connection, NotFoundError

from datetime import datetime
import uuid


app = FastAPI()

origins = [
    "http://localhost",
    "http://localhost:5173",
    "http://localhost:8081",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

REDIS_DATA_URL = "redis://redis:6379"


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.post("/todo")
async def save_todo(todo: TodoTask):
    todo.pk = str(uuid.uuid4())
    todo.created_at = datetime.now()
    return todo.save()


@app.get("/todos")
async def list_todo(request: Request, response: Response):
    return {"todos": [TodoTask.get(pk) for pk in TodoTask.all_pks()]}


@app.get("/todo/{pk}")
async def get_todo(pk: str, request: Request, response: Response):
    try:
        return TodoTask.get(pk)
    except NotFoundError:
        raise HTTPException(status_code=404, detail="Task not found")


@app.put("/todo/{pk}/resolve")
async def resolve_todo(pk: str, request: Request, response: Response):
    try:
        todo = TodoTask.get(pk)
        todo.resolved_at = datetime.now()

        return todo.save()
    except NotFoundError:
        raise HTTPException(status_code=404, detail="Task not found")


@app.put("/todo/{pk}/unresolve")
async def unresolve_todo(pk: str, request: Request, response: Response):
    try:
        todo = TodoTask.get(pk)
        todo.resolved_at = 0

        return todo.save()
    except NotFoundError:
        raise HTTPException(status_code=404, detail="Task not found")


@app.on_event("startup")
async def startup():
    TodoTask.Meta.database = get_redis_connection(url=REDIS_DATA_URL, decode_responses=True)
