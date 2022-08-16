import time
from datetime import datetime
from typing import Optional
from pydantic import validator

from redis_om import HashModel


class TodoTask(HashModel):
    title: str
    details: Optional[str]
    created_at: Optional[datetime]
    resolved_at: Optional[datetime] = datetime.fromtimestamp(0)
    ttl_left_percentage: float = 0.0

    @validator("ttl_left_percentage", always=True)
    def ttl_percentage_calculation(cls, v, values, **kwargs):
        EXPIRE_TTL = 60 * 5

        value = (time.time() - values.get("resolved_at").timestamp()) / EXPIRE_TTL

        return 0 if value < 0 else (1 - round(value, 4)) * 100

    @validator("title")
    def title_must_not_be_empty(cls, v):
        if v.strip() == "":
            raise ValueError("Must not be empty")
        return v
