FROM python:3.9-slim-buster as builder

WORKDIR /app

COPY ./requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

FROM python:3.9-alpine as runner

WORKDIR /app

COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages

COPY --from=builder /app /app

EXPOSE 5000

ENV FLASK_APP=run.py

CMD ["python", "run.py"]