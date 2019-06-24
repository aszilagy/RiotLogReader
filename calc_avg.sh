#!/bin/bash
filename="queue_tmp.txt"

first_time_list=$(date -d $(cat "$filename" | cut -d"|" -f1 | head -n1) +%s)
last_time_list=$(date -d $(cat "$filename" | cut -d"|" -f1 | tail -n1) +%s)

first_queue_pos=$(cat "$filename" | cut -d"|" -f2 | head -n1)
last_queue_pos=$(cat "$filename" | cut -d"|" -f2 | tail -n1)

queue_diff=$(expr $first_queue_pos - $last_queue_pos)
time_diff=$(expr $last_time_list - $first_time_list)

time_min=$(($time_diff/60))

echo "Logged In:" $queue_diff "players | Time Elapsed:" $time_min" minutes"
echo "Average/sec:" $((100 * $queue_diff / $time_diff)) | sed 's/..$/.&/'

average_sec=$((100 * $queue_diff / $time_diff))

echo "Queue Position:" $last_queue_pos
echo "Expected time:" $(((100 * $last_queue_pos / $average_sec)/60)) "minutes"
