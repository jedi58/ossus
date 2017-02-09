# Allow Cross-Origin by Domain

The following will set the CORS policy to allow other specific domains to request resources. This is currently useful when browsing sites with multiple domains that don't specify a CORS policy, but are being browsed using Chrome 52 - 55 inclusive (see https://bugs.chromium.org/p/chromium/issues/detail?id=633729).

```apache
<FilesMatch "\.(ttf|otf|eot|woff|css|js)$">
    <IfModule mod_headers.c>
        SetEnvIf Origin "http(s)?://(www\.)?(my-domain\.co\.uk|my-other-domain\.co\.uk)$" AccessControlAllowOrigin=$0
        Header add Access-Control-Allow-Origin %{AccessControlAllowOrigin}e env=AccessControlAllowOrigin
        Header always set Vary Origin
    </IfModule>
</FilesMatch>
```

A good resource for reading more on CORS policies is https://enable-cors.org/
