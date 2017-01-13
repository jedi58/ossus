# Clean-up ~/Downloads

If you find that `~/Downloads/` often gets too big then one solution is to automatically remove files that have been there for more than a specific number of days. The below example can be added to your crontab:

```bash
find ~/Downloads/* -mtime +5 -exec rm {} \;
```

In this example it will only keep files for 5 days, but you can change the `5` to another integer to keep files for other periods of time.
