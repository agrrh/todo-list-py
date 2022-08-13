from datetime import datetime
from typing import Optional
from pydantic import validator

from redis_om import HashModel


class TodoTask(HashModel):
    title: str
    details: Optional[str]
    created_at: Optional[datetime]
    resolved_at: Optional[datetime] = datetime.fromtimestamp(0)

    @validator("title")
    def title_must_not_be_empty(cls, v):
        if v.strip() == "":
            raise ValueError("Must not be empty")
        return v
