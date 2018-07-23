Sometimes you need to figure out where an access control issue lies in the file-system. The following command will work backwards through the path displaying the permissions.
```bash
namei -l <full-path-to-file-or-folder>
```
This will produce output such as:
```
# namei -l /var/log/httpd/access_log
f: /var/log/httpd/access_log
dr-xr-xr-x root root /
drwxr-xr-x root root var
drwxr-xr-x root root log
drwx------ root root httpd
-rw-r--r-- root root access_log
```
