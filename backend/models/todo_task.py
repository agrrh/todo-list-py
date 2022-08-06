import datetime
from typing import Optional

from redis_om import HashModel


class TodoTask(HashModel):
    title: str
    details: Optional[str]
    created: datetime.datetime = datetime.datetime.now()
    resolved: datetime.datetime = None
