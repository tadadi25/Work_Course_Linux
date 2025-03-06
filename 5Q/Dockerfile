
FROM python:3.12-slim
WORKDIR /app
COPY . /app
RUN pip install -r requirements.txt
CMD ["bash", "process_plants.sh", "/app/new_output.csv"]
