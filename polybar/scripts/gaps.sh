#!/bin/bash

# start_time=$(($(date +%s%N)/1000))

if [[ $(i3-msg -t get_binding_state | jq -r '.name') != "default"  ||  $1 != "" ]]; then
	gaps=$(i3-msg -t get_tree | jq '.nodes[] | select(.name == "DP-5").nodes[] | select(.name == "content").nodes[] | select(.fullscreen_mode == 1) | .gaps | {"inner": .inner, "outer":.outer'} | tr '\n' ' ')
	echo ${gaps:-"default"} > /tmp/gaps
else
	echo "" > /tmp/gaps
fi

 # end_time=$(($(date +%s%N)/1000))
 # duration=$(($end_time - $start_time))
 # echo $duration μs
