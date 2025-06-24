# Personal Notes & Task Management System

This is a Git-based note-taking and task management system that allows you to:
- Track daily tasks with version control
- Maintain a searchable knowledge base
- See your progress over time
- Branch and experiment with different approaches

## Directory Structure

```
notes/
├── daily/           # Daily task logs and notes
├── projects/        # Project-specific notes and tasks
├── reference/       # Reference materials and templates
├── templates/       # Reusable note templates
└── archive/         # Completed projects and old notes
```

## Daily Workflow

### 1. Morning Setup (5 minutes)
```bash
# Create today's note
./scripts/create_daily_note.sh

# Review yesterday's incomplete tasks
./scripts/review_tasks.sh
```

### 2. During the Day
- Add tasks as you think of them
- Mark tasks as complete with ✅
- Add notes and insights
- Commit changes regularly

### 3. Evening Review (10 minutes)
```bash
# Review today's progress
./scripts/daily_review.sh

# Commit all changes
git add .
git commit -m "Daily update: $(date +%Y-%m-%d)"
```

## Git Commands for Note Management

### Basic Workflow
```bash
# Start your day
git pull origin main

# Add new notes/tasks
git add notes/daily/$(date +%Y-%m-%d).md

# Commit with descriptive message
git commit -m "Add daily tasks for $(date +%Y-%m-%d)"

# Push to remote (if using GitHub/GitLab)
git push origin main
```

### Useful Git Aliases
```bash
# Add these to your ~/.gitconfig
[alias]
    daily = "!f() { git add notes/daily/$(date +%Y-%m-%d).md && git commit -m \"Daily update: $(date +%Y-%m-%d)\"; }; f"
    week = "!f() { git log --oneline --since='1 week ago' --grep='Daily update'; }; f"
    tasks = "!f() { grep -r '\\[ \\]' notes/daily/ | wc -l; }; f"
    done = "!f() { grep -r '\\[x\\]' notes/daily/ | wc -l; }; f"
```

## Task Format

Use this format for tasks:
```markdown
## Tasks

### High Priority
- [ ] Task description
- [x] Completed task

### Medium Priority  
- [ ] Another task

### Low Priority
- [ ] Future task
```

## Tips for Staying Focused

1. **Limit daily tasks** to 3-5 high-priority items
2. **Use time blocks** in your calendar
3. **Commit frequently** to maintain momentum
4. **Review weekly** to identify patterns
5. **Use branches** for experimental approaches

## Search and Navigation

```bash
# Search for specific topics
grep -r "keyword" notes/

# Find incomplete tasks
grep -r "\[ \]" notes/daily/

# Find completed tasks
grep -r "\[x\]" notes/daily/

# Search by date
find notes/daily/ -name "*.md" -exec grep -l "2024-01-15" {} \;
``` 