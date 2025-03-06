import sqlite3
from datetime import datetime
import csv

# Step 1: Get the current date and time
current_timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

# Step 2: Create a SQLite database and insert bug data
db_connection = sqlite3.connect('bugs.db')
db_cursor = db_connection.cursor()

# Create the table if it doesn't exist
db_cursor.execute('''
CREATE TABLE IF NOT EXISTS bug_reports (
    bug_id INTEGER PRIMARY KEY,
    created_at TEXT,
    report_date TEXT,
    branch TEXT,
    developer_name TEXT,
    priority_level INTEGER,
    bug_description TEXT
)
''')

# Bug data to insert into the table (without current_timestamp in the data)
bug_data = [
    (234, "2023-03-05", "br_1", "g.cohen", 3, "File name should contain date in header"),
    (235, "2023-03-06", "br_2", "s.levi", 2, "Improve performance of module A"),
    (236, "2023-03-07", "br_3", "d.klein", 1, "Fix UI bug in the login page")
]

# Insert data into the table, using current_timestamp for created_at
bug_data_with_timestamp = [(bug[0], current_timestamp, *bug[1:]) for bug in bug_data]

# Insert the data into the table
db_cursor.executemany('''
INSERT INTO bug_reports (bug_id, created_at, report_date, branch, developer_name, priority_level, bug_description) 
VALUES (?, ?, ?, ?, ?, ?, ?)
''', bug_data_with_timestamp)

# Commit changes and close the connection
db_connection.commit()

# Step 3: Create commit.sh with current timestamp and bug information
commit_info = f"""
234:{current_timestamp}:br_1:g.cohen:3:File name should contain date in header:Ensure the file name includes date.
235:{current_timestamp}:br_2:s.levi:2:Optimize performance of module A:Performance optimization for handling large datasets.
236:{current_timestamp}:br_3:d.klein:1:Fix UI bug in the login page:Fix for login page UI issue with form submission.
"""

# Write to commit.sh file
with open("commit.sh", "w") as file:
    file.write(commit_info)

# Step 4: Create CSV from SQLite database
db_cursor.execute("SELECT * FROM bug_reports")
rows = db_cursor.fetchall()

# Create the CSV file
with open('bug_reports.csv', mode='w', newline='') as file:
    csv_writer = csv.writer(file)
    csv_writer.writerow([description[0] for description in db_cursor.description])  # Column headers
    csv_writer.writerows(rows)

# Closing the connection to the database
db_connection.close()

# Final message
print("Database 'bugs.db', commit.sh, and bug_reports.csv created successfully.")
