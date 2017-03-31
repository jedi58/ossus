# Maintenance Redirect with IP Exceptions

This example also includes `HTTP:X-FORWARDED-FOR` as an example of allowing IP addresses that have been forwarded from things such as proxies.

**maintenance.conf**
```bash
RewriteEngine On
RewriteCond %{REMOTE_ADDR} !123\.456\.7\.89 #your IP address
RewriteCond %{HTTP:X-FORWARDED-FOR} !123\.456\.7\.89 #your IP address
RewriteCond %{REQUEST_URI} !\/maintenance.html
RewriteRule ^(.*)$ /maintenance/html [R=307,L]
```

This uses a `307 Temporary Redirect` to avoid Chrome (and other browsers) caching the redirect for longer than is necessary. When testing that the URI being requested is not `maintenance.html` you may also want to ensure it's not an image, CSS or other resource required by your maintenance page.
