#!/bin/bash

# Variables
DATABASE_PATH="/home/tadadi25/FinelProj/Work_Course_Linux/5Q/mydatabase.db"
CSV_FILE_PATH="/home/tadadi25/FinelProj/Work_Course_Linux/5Q/New_name.csv"  # שם הקובץ שלך
CONTAINER_NAME="mycontainer"
LOG_FILE="/home/tadadi25/FinelProj/Work_Course_Linux/5Q/container_log.txt"

# Function to check the SQLite database
check_sqlite_db() {
    echo "Checking SQLite database..." >> $LOG_FILE

    # Display all records from the table 'New_name'
    sqlite3 $DATABASE_PATH <<EOF
.headers on
.mode column
SELECT * FROM New_name;  # עדכון שם הטבלה ל-New_name
EOF

    echo "$(date) - Displayed content of the 'New_name' table from the SQLite database" >> $LOG_FILE
}

# Function to check the contents inside the container
check_container() {
    echo "Checking container contents..." >> $LOG_FILE

    # List the containers and their files
    docker exec $CONTAINER_NAME ls /app >> $LOG_FILE
    docker exec $CONTAINER_NAME cat /app/container_log.txt >> $LOG_FILE

    echo "$(date) - Displayed container contents and container log" >> $LOG_FILE
}

# Main function
main() {
    # Checking SQLite DB
    check_sqlite_db

    # Checking Docker container
    check_container
}

# Run the main function
main
