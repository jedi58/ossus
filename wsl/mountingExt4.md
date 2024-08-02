Find the device ID in PowerShell:

```
 wmic diskdrive list brief
```

Open PowerShell as Administrator if not already:

```
start-process powershell -verb runAs
```

The mount the drive:
```
wsl --mount \\.\<<DEVICEID>>
```
