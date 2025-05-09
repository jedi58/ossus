grep 'Date:' <DayOne JSON output>' | sed -r 's/ at [0-9]{2}:[0-9]{2}:[0-9]{2} .*//g' | sed -r 's/[^A-Z]+Date:[^0-9]+//g' | sort | uniq -d
