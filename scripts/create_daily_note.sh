#!/bin/bash

# Create daily note script
# Usage: ./scripts/create_daily_note.sh

# Get current date and time
DATE=$(date +%Y-%m-%d)
DAY=$(date +%A)
WEEK=$(date +%V)
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# Create daily directory if it doesn't exist
mkdir -p notes/daily

# Check if today's note already exists
if [ -f "notes/daily/${DATE}.md" ]; then
    echo "Today's note already exists: notes/daily/${DATE}.md"
    exit 0
fi

# Create today's note from template
cp notes/templates/daily_template.md "notes/daily/${DATE}.md"

# Replace template variables
sed -i.bak "s/{{DATE}}/${DATE}/g" "notes/daily/${DATE}.md"
sed -i.bak "s/{{DAY}}/${DAY}/g" "notes/daily/${DATE}.md"
sed -i.bak "s/{{WEEK}}/${WEEK}/g" "notes/daily/${DATE}.md"
sed -i.bak "s/{{TIMESTAMP}}/${TIMESTAMP}/g" "notes/daily/${DATE}.md"

# Remove backup file
rm "notes/daily/${DATE}.md.bak"

echo "Created daily note: notes/daily/${DATE}.md"
echo "Opening in default editor..."

# Open the file in the default editor
if command -v code &> /dev/null; then
    code "notes/daily/${DATE}.md"
elif command -v vim &> /dev/null; then
    vim "notes/daily/${DATE}.md"
else
    open "notes/daily/${DATE}.md"
fi 