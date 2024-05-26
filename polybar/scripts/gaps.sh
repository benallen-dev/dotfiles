#!/bin/bash

start_time=$(($(date +%s%N)/1000))

if [ $(i3-msg -t get_binding_state | jq -r '.name') != "default" ]; then
	gaps=$(i3-msg -t get_tree | jq '..|.gaps? | select(.!=null) | select(.inner!=0) | .inner')
	echo ${gaps:-"default"} > /tmp/gaps
else
	echo "" > /tmp/gaps
fi

 end_time=$(($(date +%s%N)/1000))
 duration=$(($end_time - $start_time))
 echo $duration μs
