FROM python:3.8.12-slim-buster
WORKDIR /app
COPY . .
RUN pip install flask

CMD ["python3", "main.py"]