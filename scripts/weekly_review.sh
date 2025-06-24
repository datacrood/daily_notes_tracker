#!/bin/bash

# Weekly review script
# Usage: ./scripts/weekly_review.sh

# Get current week info
WEEK_NUMBER=$(date +%V)
WEEK_START=$(date -v-monday +%Y-%m-%d 2>/dev/null || date -d "monday this week" +%Y-%m-%d)
WEEK_END=$(date -v-sunday +%Y-%m-%d 2>/dev/null || date -d "sunday this week" +%Y-%m-%d)
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# Create weekly directory if it doesn't exist
mkdir -p notes/weekly

# Check if this week's review already exists
if [ -f "notes/weekly/week-${WEEK_NUMBER}-${WEEK_START}.md" ]; then
    echo "This week's review already exists: notes/weekly/week-${WEEK_NUMBER}-${WEEK_START}.md"
    exit 0
fi

# Create weekly review from template
cp notes/templates/weekly_review_template.md "notes/weekly/week-${WEEK_NUMBER}-${WEEK_START}.md"

# Replace template variables
sed -i.bak "s/{{WEEK_NUMBER}}/${WEEK_NUMBER}/g" "notes/weekly/week-${WEEK_NUMBER}-${WEEK_START}.md"
sed -i.bak "s/{{WEEK_START}}/${WEEK_START}/g" "notes/weekly/week-${WEEK_NUMBER}-${WEEK_START}.md"
sed -i.bak "s/{{WEEK_END}}/${WEEK_END}/g" "notes/weekly/week-${WEEK_NUMBER}-${WEEK_START}.md"
sed -i.bak "s/{{TIMESTAMP}}/${TIMESTAMP}/g" "notes/weekly/week-${WEEK_NUMBER}-${WEEK_START}.md"

# Remove backup file
rm "notes/weekly/week-${WEEK_NUMBER}-${WEEK_START}.md.bak"

echo "Created weekly review: notes/weekly/week-${WEEK_NUMBER}-${WEEK_START}.md"

# Generate weekly statistics
echo ""
echo "=== Weekly Statistics ==="

# Count total tasks for the week
TOTAL_TASKS=0
COMPLETED_TASKS=0

for file in notes/daily/*.md; do
    if [ -f "$file" ]; then
        # Check if file is from this week
        FILE_DATE=$(basename "$file" .md)
        if [[ "$FILE_DATE" >= "$WEEK_START" && "$FILE_DATE" <= "$WEEK_END" ]]; then
            WEEK_TASKS=$(grep -c "\[ \]\|\[x\]" "$file" || echo "0")
            WEEK_COMPLETED=$(grep -c "\[x\]" "$file" || echo "0")
            TOTAL_TASKS=$((TOTAL_TASKS + WEEK_TASKS))
            COMPLETED_TASKS=$((COMPLETED_TASKS + WEEK_COMPLETED))
        fi
    fi
done

COMPLETION_RATE=0
if [ $TOTAL_TASKS -gt 0 ]; then
    COMPLETION_RATE=$((COMPLETED_TASKS * 100 / TOTAL_TASKS))
fi

echo "📊 Week ${WEEK_NUMBER} Summary:"
echo "   📅 Period: ${WEEK_START} to ${WEEK_END}"
echo "   ✅ Completed: ${COMPLETED_TASKS}"
echo "   📋 Total: ${TOTAL_TASKS}"
echo "   📈 Completion Rate: ${COMPLETION_RATE}%"

# Show daily breakdown
echo ""
echo "📅 Daily Breakdown:"
for file in notes/daily/*.md; do
    if [ -f "$file" ]; then
        FILE_DATE=$(basename "$file" .md)
        if [[ "$FILE_DATE" >= "$WEEK_START" && "$FILE_DATE" <= "$WEEK_END" ]]; then
            DAY_COMPLETED=$(grep -c "\[x\]" "$file" || echo "0")
            DAY_TOTAL=$(grep -c "\[ \]\|\[x\]" "$file" || echo "0")
            DAY_NAME=$(date -j -f "%Y-%m-%d" "$FILE_DATE" +%A 2>/dev/null || date -d "$FILE_DATE" +%A)
            echo "   ${DAY_NAME} (${FILE_DATE}): ${DAY_COMPLETED}/${DAY_TOTAL}"
        fi
    fi
done

echo ""
echo "Opening weekly review for editing..."
if command -v code &> /dev/null; then
    code "notes/weekly/week-${WEEK_NUMBER}-${WEEK_START}.md"
elif command -v vim &> /dev/null; then
    vim "notes/weekly/week-${WEEK_NUMBER}-${WEEK_START}.md"
else
    open "notes/weekly/week-${WEEK_NUMBER}-${WEEK_START}.md"
fi 