# PHP-compatible SHA-1 hashes in MS-SQL

In Microsoft SQL Server you can use the `HASHBYTES` function to produce `SHA1` hashes of strings. These however are not "compatible" with SHA-1 hashes produced from PHP or MySQL. If for example you want to look in MS-SQL for a simple password hash (obviously passwords would not normally be handled in this way!) then you could use something such as:

```sql
DECLARE @password varchar = '%this-is-your-string%';

SELECT sys.fn_varbintohexsubstring(0, HASHBYTES('SHA1', @password), 1, 0);
```

The result of this will then be a SHA-1 hash, the same as if generated from PHP or MySQL.
