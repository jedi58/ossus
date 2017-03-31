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

By having this in it's conf file it can be dropped in and out quickly as required.


## Scheduled Downtime
This could be done by moving the conf file in and out of a location using a cron table entry (along with a httpd graceful) however this is not ideal as it could bring down your site if there's an error. This can instead be done using something such as:

```bash
RewriteEngine On
RewriteCond %{REMOTE_ADDR} !123\.456\.7\.89 #your IP address
RewriteCond %{HTTP:X-FORWARDED-FOR} !123\.456\.7\.89 #your IP address
RewriteCond %{TIME} >20171011073000
RewriteCond %{TIME} <20171011080000
RewriteCond %{REQUEST_URI} !\/maintenance.html
RewriteRule ^(.*)$ /maintenance/html [R=307,L]
```

This means that the site would then be down between 07:30 and 08:00 on 11th October 2017. Further improvements to this might include getting the "up" and "down" times from a file (which could be written to from a CMS) or replacing `%{TIME}` with a check to see if a particular file exists. This latter option would mean your CMS solution would need to handle the writing and removing of this file at the specified times. An example of this would be to replace those lines with:

```bash
RewriteCond %{DOCUMENT_ROOT}%/offline.txt -f
```

In this case it would only redirect to the maintenance page if a file called `offline.html` exists in the site root.
