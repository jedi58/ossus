# Exclude Resources from Logfile

If you've got a HTTP, IIS, or other access log that you need to review and/or perform some analysis on you can easily exclude resources (images, javascript, stylesheets, etc.) using the following:

```bash
grep -vE '\.(css|jpe?g|png|ico|js|eot|gif|wof|svg|mp4|webmanifest)'
```

The `v` switch is telling `grep` to exclude what it matches from the output, and the `E` followed by the regular expression tells it what file extensions to ignore.
