import sqlite3
import csv

# Create a connection to the SQLite database
conn = sqlite3.connect('/home/tadadi25/FinelProj/Work_Course_Linux/4Q/orchids.db')
cursor = conn.cursor()

# Create the orchids table if it does not exist
cursor.execute('''CREATE TABLE IF NOT EXISTS orchids (
                    plant TEXT, 
                    height TEXT, 
                    leaf_count TEXT, 
                    dry_weight TEXT)''')

# Insert data into the table
cursor.executemany('''INSERT INTO orchids (plant, height, leaf_count, dry_weight)
                       VALUES (?, ?, ?, ?)''', [
    ('Phalaenopsis', '30 35 40 45 50', '10 12 14 16 18', '0.5 0.6 0.7 0.8 1.0'),
    ('Cattleya', '25 30 35 40 45', '8 10 12 14 16', '0.4 0.5 0.6 0.7 0.8'),
    ('Dendrobium', '50 55 60 65 70', '15 18 20 22 25', '0.8 1.0 1.2 1.4 1.6'),
    ('Vanda', '40 45 50 55 60', '20 22 24 26 28', '1.2 1.4 1.6 1.8 2.0'),
    ('Oncidium', '60 65 70 75 80', '25 30 35 40 45', '2.0 2.3 2.5 2.8 3.0')
])

# Commit the changes to the database
conn.commit()

# Export the data to a new CSV file with a different name
cursor.execute('SELECT * FROM orchids')
rows = cursor.fetchall()

with open('/home/tadadi25/FinelProj/Work_Course_Linux/4Q/orchids_schals_data.csv', 'w', newline='') as f:
    writer = csv.writer(f)
    writer.writerow(['Plant', 'Height', 'Leaf Count', 'Dry Weight'])  # Column headers
    writer.writerows(rows)

# Close the database connection
conn.close()

print("CSV file has been created successfully!")
