#!/bin/bash

LOG_FILE="/home/tadadi25/FinelProj/Work_Course_Linux/5Q/container_log.txt"
CONTAINER_NAME="mycontainer"
echo "$(date) - Starting to check containers and their files..." >> $LOG_FILE
echo "$(date) - Container name: $CONTAINER_NAME" >> $LOG_FILE
docker exec $CONTAINER_NAME ls /app >> $LOG_FILE
echo "$(date) - Files remaining in $CONTAINER_NAME:" >> $LOG_FILE
docker exec $CONTAINER_NAME ls /app
echo "$(date) - Finished checking files in the container" >> $LOG_FILE
