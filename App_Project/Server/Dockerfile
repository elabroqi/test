FROM python:3.11-slim

WORKDIR /app

COPY server.py .
COPY images ./images

EXPOSE 9000

CMD ["python", "server.py"]

