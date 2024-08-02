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
You can then view the drive under Explorer as Linux, or in wsl under the `/mnt` location
