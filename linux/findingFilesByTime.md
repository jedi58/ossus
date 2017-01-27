# Finding Files by Time

To find the newest file in a folder:
```bash
find -type f -printf '%T+ %p\n' | sort | head -n 1
```

To find the oldest file in a folder:
```bash
find -type f -printf '%T+ %p\n' | sort -r | head -n 1
```

To get the number of files created in a specific day/month/year; example files created in 2016:
```
ls --full-time | grep -i '2016-' | wc -l
```
