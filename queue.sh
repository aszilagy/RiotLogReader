#!/bin/bash
filename="$(ls -t | egrep 'LeagueClient.log' | head -n 1)"
m1=$(grep 'queue position' "$filename" | tail -n 1 | cut -d '|' -f4)

echo Reading from "$filename"
echo $m1

while true; 
do 
	m2=$(grep 'queue position' "$filename" | tail -n 1 | cut -d '|' -f4); 
	if [ "$m1" != "$m2" ]; then
		echo $m2
		echo "$(date +'%T') | $(echo $m2 | cut -d' ' -f5)" >> queue_tmp.txt
		m1=$m2
	else
		sleep 1
	fi
done
