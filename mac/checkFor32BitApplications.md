# Check for 32-bit Applications

From the terminal run:

```bash
file /Applications/*/Contents/MacOS/* | grep i386 | grep -v x86_64
```

This will list all applications that are 32-bit only and do not support 64-bit architecture. Something which will be useful if you're upgrading to Mac OS High Sierra - the first to be 64-bit only.
