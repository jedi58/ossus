# Expiring Content with Apache mod_expire

One way to help with performance issues is to make sure that files that are rarely changed are cached on subsequent visits - this is something that can be affected by Apache's configuration so that the least changed files are cached the longest. All you need to do this is the mod_expire extension and a few changes to either your server server config file, a virtual host or directory, or a .htaccess file if you don't have direct access to Apache's configuration.

When you're using Apache you have a directive available to you that can manipulate what headers are sent with files so that the browser knows how to cache the file, if it should. This can even me manipulated by Content-Type so that if you know that any GIFs on your site are design images and are unlikely to change you could send an expiry header which is greater than the rest of your site. An example of this might be to use:

```
ExpiresActive On
ExpiresByType image/gif A2592000
ExpiresByType application/zip M31536000
```

So in this example we are saying that a GIF will expire in the client's cache a month after it was accessed. The third line then states that any ZIP files will expire in the client's cache a year after the file was last modified. The syntax is as follows:

```
ExpiresByType <content-type> <base><seconds>
```

The content type is determined by the MIME type of the file, and the base can either be Access (A) or Modified (M). There is also Now (N), but that is an equivalent of A.

In addition to expiring content by type we can also change the default expiration time for any other files. We can do this using a directive such as:

```
ExpiresDefault M3600
```

For this example content with expire by default one hour after the file was last modified. The downside to that is that after that first hour it will no longer be kept in the cache at all unless it is modified again. A better method would be to replace the M with an A so that it lasts for an hour after they've accessed it. This isn't necessarily a good expiration time, and is only used as an example of what it could be. Before using ExpiresDefault or ExpiresByType you must ensure that you have used the ExpiresActive On directive.
