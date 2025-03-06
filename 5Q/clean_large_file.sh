#!/bin/bash

# משתנים
REPO_URL="https://github.com/tadadi25/Work_Course_Linux.git"
WORK_DIR="$HOME/Work_Course_Linux_clean"

# מחיקה אם קיים
rm -rf "$WORK_DIR"

# Clone חדש ונקי
git clone "$REPO_URL" "$WORK_DIR"

# מעבר לתיקייה
cd "$WORK_DIR"

# ניקוי מלא מהיסטוריה
git filter-repo --path 5Q/txt.output_5 --invert-paths

# דחיפה בכוח
git push origin main --force

echo "✅ ההיסטוריה נוקתה בהצלחה והקובץ txt.output_5 הוסר לחלוטין מגיטהב."
