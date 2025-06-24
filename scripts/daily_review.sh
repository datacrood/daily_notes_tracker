#!/bin/bash

# Daily review script
# Usage: ./scripts/daily_review.sh

DATE=$(date +%Y-%m-%d)
YESTERDAY=$(date -v-1d +%Y-%m-%d 2>/dev/null || date -d "yesterday" +%Y-%m-%d)

echo "=== Daily Review for ${DATE} ==="
echo ""

# Check if today's note exists
if [ ! -f "notes/daily/${DATE}.md" ]; then
    echo "❌ Today's note not found. Run ./scripts/create_daily_note.sh first."
    exit 1
fi

# Count incomplete tasks
INCOMPLETE=$(grep -c "\[ \]" "notes/daily/${DATE}.md" || echo "0")
COMPLETED=$(grep -c "\[x\]" "notes/daily/${DATE}.md" || echo "0")

echo "📊 Task Summary:"
echo "   ✅ Completed: ${COMPLETED}"
echo "   ⏳ Incomplete: ${INCOMPLETE}"

if [ "$INCOMPLETE" -gt 0 ]; then
    echo ""
    echo "📝 Incomplete tasks:"
    grep "\[ \]" "notes/daily/${DATE}.md" | sed 's/^/   /'
fi

# Check for yesterday's incomplete tasks
if [ -f "notes/daily/${YESTERDAY}.md" ]; then
    YESTERDAY_INCOMPLETE=$(grep -c "\[ \]" "notes/daily/${YESTERDAY}.md" || echo "0")
    if [ "$YESTERDAY_INCOMPLETE" -gt 0 ]; then
        echo ""
        echo "🔄 Yesterday's incomplete tasks:"
        grep "\[ \]" "notes/daily/${YESTERDAY}.md" | sed 's/^/   /'
    fi
fi

echo ""
echo "💡 Tips:"
echo "   - Move incomplete tasks to tomorrow's note"
echo "   - Add insights to the Evening Reflection section"
echo "   - Commit your changes: git add . && git commit -m 'Daily update: ${DATE}'"
echo ""

# Prompt for evening reflection
read -p "Would you like to add evening reflection now? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Opening today's note for evening reflection..."
    if command -v code &> /dev/null; then
        code "notes/daily/${DATE}.md"
    elif command -v vim &> /dev/null; then
        vim "notes/daily/${DATE}.md"
    else
        open "notes/daily/${DATE}.md"
    fi
fi 