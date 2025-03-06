import sqlite3

# יצירת חיבור למסד הנתונים SQLite
conn = sqlite3.connect('/home/tadadi25/FinelProj/Work_Course_Linux/5Q/mydatabase.db')
cursor = conn.cursor()

# יצירת טבלה אם היא לא קיימת
cursor.execute('''
CREATE TABLE IF NOT EXISTS sql_table (
    date_collected TEXT,
    species TEXT,
    sex TEXT,
    weight INTEGER
)
''')

# הוספת נתונים לטבלה
data = [
    ('1/8', 'PF', 'M', 7),
    ('2/18', 'OT', 'M', 24),
    ('2/19', 'OT', 'F', 23),
    ('3/11', 'NA', 'M', 232),
    ('3/11', 'OT', 'F', 22),
    ('3/11', 'OT', 'M', 26),
    ('3/11', 'PF', 'M', 8),
    ('4/8', 'NA', 'F', 8),
    ('5/6', 'NA', 'F', 45),
    ('5/18', 'NA', 'F', 182),
    ('6/9', 'OT', 'F', 29)
]

# הוספת הנתונים לטבלה
cursor.executemany('''
INSERT INTO sql_table (date_collected, species, sex, weight)
VALUES (?, ?, ?, ?)
''', data)

# שמירת השינויים במסד הנתונים
conn.commit()

# הצגת הנתונים מתוך הטבלה
cursor.execute('SELECT * FROM sql_table')
rows = cursor.fetchall()

# הצגת הנתונים שנשמרו
for row in rows:
    print(row)

# סגירת החיבור למסד הנתונים
conn.close()

print("Data has been inserted and retrieved from the SQLite table!")
