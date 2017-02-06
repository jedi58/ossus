# Allow Cross-Origin by Domain

The following will set the CORS policy to allow other specific domains to request resources

```apache
<FilesMatch "\.(ttf|otf|eot|woff|css|js)$">
    <IfModule mod_headers.c>
        SetEnvIf Origin "http(s)?://(www\.)?(my-domain\.co\.uk|my-other-domain\.co\.uk)$" AccessControlAllowOrigin=$0
        Header add Access-Control-Allow-Origin %{AccessControlAllowOrigin}e env=AccessControlAllowOrigin
    </IfModule>
</FilesMatch>
```
