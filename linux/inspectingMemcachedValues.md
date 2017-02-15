# Inspecting `memcached` Values

You can interact with `memcached` using `telnet` though to make it simpler you can use `nc` (NetCat) with the below:

```bash
echo "stats cachedump <<slab-id>> 0" | nc localhost 11211 | sed -e 's/\[/\[ /g' | sort -k4 -rn | more
```

This will output the contents of `memcached`, sorted by descending memory usage, in the format of:

```
ITEM <<key>> [<<memory usage>> b; <<expiry-time>> s]
```

Memory usage is in bytes, and expiry time is the number of seconds since the UNIX epoch. Keys may expire sooner if a slab is full and the space if required by a new entry. Otherwise a record is removed from memory once accessed after the expiry time. The `cachedump` only outputs a single slab so this will need using for each slab you need to inspect. You can find the number of slabs using:

```bash
echo "stats slabs" | nc localhost 11211
```

This will then output something like `STAT active_slabs 38`.
