#!/bin/bash

# Default CSV file creation
CSV_FILE="origin_csv.csv"
<<<<<<< HEAD
LOG_FILE="output_5.txt"  # Log file to store all the outputs
=======
LOG_FILE="txt.output_5"  # Log file to store all the outputs
>>>>>>> e270d5ce1e757ad919733dc6ff1a5e3d52fb43f3

# Create the CSV file with data
create_csv() {
    echo "Date collected,Species,Sex,Weight" > $CSV_FILE
    echo "1/8,PF,M,7" >> $CSV_FILE
    echo "2/18,OT,M,24" >> $CSV_FILE
    echo "2/19,OT,F,23" >> $CSV_FILE
    echo "3/11,NA,M,232" >> $CSV_FILE
    echo "3/11,OT,F,22" >> $CSV_FILE
    echo "3/11,OT,M,26" >> $CSV_FILE
    echo "3/11,PF,M,8" >> $CSV_FILE
    echo "4/8,NA,F,8" >> $CSV_FILE
    echo "5/6,NA,F,45" >> $CSV_FILE
    echo "5/18,NA,F,182" >> $CSV_FILE
    echo "6/9,OT,F,29" >> $CSV_FILE
}

# Menu display and option selection
while true; do
    echo "Please choose an option:" | tee -a $LOG_FILE
    echo "1. CREATE CSV by name" | tee -a $LOG_FILE
    echo "2. Display all CSV DATA with row INDEX" | tee -a $LOG_FILE
    echo "3. Read user input for new row" | tee -a $LOG_FILE
    echo "4. Read Specie (OT for example) And Display all Items of that specie type and the AVG weight of that type" | tee -a $LOG_FILE
    echo "5. Read Specie sex (M/F) and display all items of specie-sex" | tee -a $LOG_FILE
    echo "6. Save last output to new csv file" | tee -a $LOG_FILE
    echo "7. Delete row by row index" | tee -a $LOG_FILE
    echo "8. Update weight by row index" | tee -a $LOG_FILE
    echo "9. Exit" | tee -a $LOG_FILE

    read -p "Enter your choice (1-9): " choice

    case $choice in
        1)
            # Create CSV and allow user to change the name
            create_csv
            echo "CSV created with name $CSV_FILE" | tee -a $LOG_FILE
            read -p "Do you want to rename the CSV file? (y/n): " rename_choice
            if [ "$rename_choice" == "y" ]; then
                read -p "Enter new CSV file name (without path): " new_name
                mv $CSV_FILE $new_name
                CSV_FILE=$new_name
                echo "CSV renamed to $CSV_FILE" | tee -a $LOG_FILE
            fi
            ;;
        2)
            # Display all CSV data with row index
            echo "Displaying CSV Data with Index:" | tee -a $LOG_FILE
            awk 'BEGIN {OFS=","} {print NR, $0}' $CSV_FILE | tee -a $LOG_FILE
            ;;
        3)
            # Read user input for a new row and add it to the CSV
            read -p "Enter Date collected: " date_collected
            read -p "Enter Species: " species
            read -p "Enter Sex (M/F): " sex
            read -p "Enter Weight: " weight
            echo "$date_collected,$species,$sex,$weight" >> $CSV_FILE
            echo "New row added successfully." | tee -a $LOG_FILE
            ;;
        4)
            # Read Specie and display items of that species type and AVG weight
            read -p "Enter Specie (e.g., OT): " specie
            echo "Displaying items for Specie: $specie" | tee -a $LOG_FILE
            awk -F, -v specie="$specie" '$2 == specie {print $0}' $CSV_FILE | tee -a $LOG_FILE
            awk -F, -v specie="$specie" '$2 == specie {sum+=$4; count++} END {print "Average weight: ", sum/count}' $CSV_FILE | tee -a $LOG_FILE
            ;;
        5)
            # Read Specie sex (M/F) and display items of specie-sex
            read -p "Enter Specie sex (M/F): " sex_specie
            echo "Displaying items for Specie sex: $sex_specie" | tee -a $LOG_FILE
            awk -F, -v sex_specie="$sex_specie" '$3 == sex_specie {print $0}' $CSV_FILE | tee -a $LOG_FILE
            ;;
        6)
            # Save last output to a new CSV file
            echo "Saving last output to new CSV..." | tee -a $LOG_FILE
            cp $CSV_FILE "new_output.csv"
            echo "New CSV file created: new_output.csv" | tee -a $LOG_FILE
            ;;
        7)
            # Delete row by row index
            read -p "Enter row index to delete: " row_index
            sed -i "${row_index}d" $CSV_FILE
            echo "Row $row_index deleted." | tee -a $LOG_FILE
            ;;
        8)
            # Update weight by row index
            read -p "Enter row index to update: " row_index
            read -p "Enter new weight: " new_weight
            sed -i "${row_index}s/\([0-9]\{1,\}\)$/\1,$new_weight/" $CSV_FILE
            echo "Row $row_index updated with new weight." | tee -a $LOG_FILE
            ;;
        9)
            # Exit
            echo "Exiting..." | tee -a $LOG_FILE
            exit 0
            ;;
        *)
            echo "Invalid option. Please enter a number between 1 and 9." | tee -a $LOG_FILE
            ;;
    esac
done
