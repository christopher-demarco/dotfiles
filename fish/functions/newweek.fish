function newweek
    python3 -c "
from datetime import date, timedelta
today = date.today()
monday = today - timedelta(days=today.weekday())
prev_monday = monday - timedelta(days=7)
filename = f\"/Users/cdemarco/.config/zk/drw/Week of {monday.strftime('%Y-%m-%d')}.md\"
content = f\"[[Week of {prev_monday.strftime('%Y-%m-%d')}]]\n\n\"
day_labels = ['M', 'T', 'W', 'R', 'F']
for i, label in enumerate(day_labels):
    day_date = monday + timedelta(days=i)
    content += f\"- {label} {day_date.strftime('%m-%d')}\n\"
open(filename, 'w').write(content)
print(f'Created: {filename}')
"
end
