cat apache_access_log | awk '{print $1}' | sort -n | uniq -c | sort -nr | head -20
