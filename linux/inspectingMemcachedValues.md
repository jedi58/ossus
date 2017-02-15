# Inspecting `memcached` Values

You can interact with `memcached` using `telnet` though to display everything you can use `nc` (NetCat) with the below:

```bash
echo "stats cachedump 5 0" | nc localhost 11211 | more
```
