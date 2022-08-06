from datetime import datetime
from typing import Optional

from redis_om import HashModel


class TodoTask(HashModel):
    title: str
    details: Optional[str]
    created_at: Optional[datetime]
    resolved_at: Optional[datetime] = 0
