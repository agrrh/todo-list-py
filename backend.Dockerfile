FROM python:3.10-alpine

WORKDIR /app

COPY ./backend/requirements.txt ./
RUN pip install -r requirements.txt

COPY ./backend ./

CMD ["python"]
ARG ["main.py"]
