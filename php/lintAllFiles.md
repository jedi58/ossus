# Lint All PHP Files in a Folder

This will recursively syntax check all PHP files with the exception of any dependencies pulled into the vendor folder if it exists.

```bash
find -L . -name '*.php' -not -path '*/vendor/*' -print0 | xargs -0 -n 1 -P 4 php -l | grep 'Parse'
```

Alternatively, add https://github.com/JakubOnderka/PHP-Parallel-Lint to a project for even faster and better formatted lint-ing
