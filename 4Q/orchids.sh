#!/bin/bash

# Set the path for the virtual environment
VENV_DIR="/home/tadadi25/FinelProj/Work_Course_Linux/4Q/ENV_FOR_Q4"
LOG_FILE="/home/tadadi25/FinelProj/Work_Course_Linux/4Q/log_plant_plots.log"

# Function to create and activate the virtual environment
create_virtual_env() {
    if [ ! -d "$VENV_DIR" ]; then
        echo "$(date) - Virtual environment not found, creating one..." >> $LOG_FILE
        python3 -m venv $VENV_DIR
        source $VENV_DIR/bin/activate
        echo "$(date) - Installing required packages..." >> $LOG_FILE
        pip install -r /home/tadadi25/FinelProj/Work_Course_Linux/4Q/requirements.txt
    else
        echo "$(date) - Virtual environment already exists, activating..." >> $LOG_FILE
        source $VENV_DIR/bin/activate
    fi
}

# Function to run the python script for each plant in the CSV file
run_python_script_for_csv() {
    CSV_FILE=$1
    while IFS=, read -r plant height leaf_count dry_weight; do
        # Skip the header row
        if [ "$plant" != "Plant" ]; then
            echo "$(date) - Processing plant: $plant" >> $LOG_FILE

            # Create a directory for the plant
            mkdir -p /home/tadadi25/FinelProj/Work_Course_Linux/4Q/$plant

            # Run the python script with the parameters
            python3 /home/tadadi25/FinelProj/Work_Course_Linux/4Q/plant.py \
                --plant "$plant" \
                --height $height \
                --leaf_count $leaf_count \
                --dry_weight $dry_weight

            # Check if the Python script ran successfully
            if [ $? -eq 0 ]; then
                echo "$(date) - Python script executed successfully for $plant" >> $LOG_FILE
                # Move the generated plots to the plant's directory
                mv /home/tadadi25/FinelProj/Work_Course_Linux/4Q/${plant}_*.png /home/tadadi25/FinelProj/Work_Course_Linux/4Q/$plant/
            else
                echo "$(date) - ERROR: Python script failed for $plant" >> $LOG_FILE
            fi
        fi
    done < $CSV_FILE
}

# Main script execution
echo "$(date) - Starting the process..." >> $LOG_FILE
create_virtual_env
run_python_script_for_csv /home/tadadi25/FinelProj/Work_Course_Linux/4Q/orchids_data.csv
echo "$(date) - Process completed." >> $LOG_FILE
