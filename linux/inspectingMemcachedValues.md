# Inspecting `memcached` Values

You can interact with `memcached` using `telnet` though to display everything you can use `nc` (NetCat) with the below:

```bash
echo "stats cachedump 5 0" | nc localhost 11211 | sed -e 's/\[/\[ /g' | sort -k4 -n | more
```

This will output the contents of `memcached`, sorted by ascending memory usage, in the format of:

```
ITEM <<key>> [<<memory usage>> b; <<expiry-time>> s]
```

Memory usage is in bytes, and expiry time is the number of seconds since the UNIX epoch. Keys may expire sooner if a slab is full and the space if required by a new entry. Otherwise a record is removed from memory once accessed after the expiry time.
