
FROM python:3.12-slim
WORKDIR /app
COPY . /app
RUN pip install -r requirements.txt
CMD ["bash", "process_plants.sh", "/app/New_name_plants.csv"]



FROM rocker/r-ver:4.2.1
WORKDIR /app
COPY . /app
RUN R -e "install.packages('dplyr')"
RUN R -e "install.packages('ggplot2')"
CMD ["Rscript", "process_plants.R", "/app/New_name_plants.csv"]

