# Quick Start Guide

## 🚀 Get Started in 5 Minutes

### 1. Make Scripts Executable
```bash
chmod +x scripts/*.sh
```

### 2. Create Your First Daily Note
```bash
./scripts/create_daily_note.sh
```

### 3. Add Your Tasks
- Open the generated note in your editor
- Add 3-5 high-priority tasks
- Set your energy and focus scores
- Plan your time blocks

### 4. Track Progress Throughout the Day
- Mark tasks as complete: `[ ]` → `[x]`
- Add notes and insights
- Record distractions and interruptions

### 5. Evening Review
```bash
./scripts/daily_review.sh
```

### 6. Commit Your Progress
```bash
git add .
git commit -m "Daily update: $(date +%Y-%m-%d)"
```

## 📅 Daily Workflow

### Morning (5 minutes)
1. Run `./scripts/create_daily_note.sh`
2. Review yesterday's incomplete tasks
3. Set 3 main priorities for today
4. Plan your time blocks

### During the Day
- Update tasks as you complete them
- Add notes and insights
- Record what distracts you

### Evening (10 minutes)
1. Run `./scripts/daily_review.sh`
2. Reflect on what went well/poorly
3. Plan tomorrow's focus
4. Commit your changes

## 🔄 Weekly Review (30 minutes)
```bash
./scripts/weekly_review.sh
```

## 💡 Pro Tips

### Stay Focused
- **Limit daily tasks** to 3-5 items maximum
- **Use time blocks** in your calendar
- **Commit frequently** to maintain momentum
- **Review patterns** weekly to identify distractions

### Git Best Practices
- Commit at least once per day
- Use descriptive commit messages
- Create branches for experimental approaches
- Push to remote for backup

### Search Your Notes
```bash
# Find all incomplete tasks
grep -r "\[ \]" notes/daily/

# Search for specific topics
grep -r "keyword" notes/

# Find completed tasks from last week
find notes/daily/ -name "*.md" -exec grep -l "\[x\]" {} \;
```

## 🎯 Success Metrics

Track these to improve your focus:
- **Daily task completion rate**
- **Focus score consistency**
- **Distraction frequency**
- **Weekly review completion**

## 🆘 Troubleshooting

### Scripts not working?
```bash
# Check if scripts are executable
ls -la scripts/

# Make them executable
chmod +x scripts/*.sh
```

### Can't find your notes?
```bash
# List all daily notes
ls notes/daily/

# Search for specific content
grep -r "your search term" notes/
```

### Git issues?
```bash
# Check status
git status

# See recent commits
git log --oneline -10
```

## 📚 Next Steps

1. **Set up Git aliases** in `~/.gitconfig` (see main README)
2. **Create project-specific notes** in `notes/projects/`
3. **Build your reference library** in `notes/reference/`
4. **Experiment with different templates** in `notes/templates/`

---

*Remember: The goal is progress, not perfection. Start small and build consistency!* 