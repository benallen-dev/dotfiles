#!/usr/bin/env bash

# Honestly this feels like one of those times where I should be reaching for
# an actual programming language, but the convention for polybar modules is to
# use shell scripts, so I'm just gonna challenge myself

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/weather.sh.config" 2>/dev/null

# These glyphs will likely not display correctly as you're supposed to set the font for this module to 'weather-icons': https://aur.archlinux.org/packages/ttf-weather-icons
declare -A wind_dir_icons
wind_dir_icons["N"]=""
wind_dir_icons["NE"]=""
wind_dir_icons["E"]=""
wind_dir_icons["SE"]=""
wind_dir_icons["S"]=""
wind_dir_icons["SW"]=""
wind_dir_icons["W"]=""
wind_dir_icons["NW"]=""

declare -A wind_spd_icons
wind_spd_icons["0"]=""
wind_spd_icons["1"]=""
wind_spd_icons["2"]=""
wind_spd_icons["3"]=""
wind_spd_icons["4"]=""
wind_spd_icons["5"]=""
wind_spd_icons["6"]=""
wind_spd_icons["7"]=""
wind_spd_icons["8"]=""
wind_spd_icons["9"]=""
wind_spd_icons["10"]=""
wind_spd_icons["11"]=""
wind_spd_icons["12"]=""

declare -A weather_icons
weather_icons["thunderstorm with light rain"]="󰖓"
weather_icons["thunderstorm with rain"]="󰖓"
weather_icons["thunderstorm with heavy rain"]="󰖓"
weather_icons["light thunderstorm"]="󰖓"
weather_icons["thunderstorm"]="󰖓"
weather_icons["heavy thunderstorm"]="󰖓"
weather_icons["ragged thunderstorm"]="󰖓"
weather_icons["thunderstorm with light drizzle"]="󰖓"
weather_icons["thunderstorm with drizzle"]="󰖓"
weather_icons["thunderstorm with heavy drizzle"]="󰖓"
weather_icons["light intensity drizzle"]="󰖖"
weather_icons["drizzle"]="󰖖"
weather_icons["heavy intensity drizzle"]="󰖖"
weather_icons["light intensity drizzle rain"]="󰖖"
weather_icons["drizzle rain"]="󰖖"
weather_icons["heavy intensity drizzle rain"]="󰖖"
weather_icons["shower rain and drizzle"]="󰖖"
weather_icons["heavy shower rain and drizzle"]="󰖖"
weather_icons["shower drizzle"]="󰖖"
weather_icons["light rain"]="󰖖"
weather_icons["moderate rain"]="󰖖"
weather_icons["heavy intensity rain"]="󰖖"
weather_icons["very heavy rain"]="󰖖"
weather_icons["extreme rain"]="󰖖"
weather_icons["freezing rain"]="󰖖"
weather_icons["light intensity shower rain"]="󰖖"
weather_icons["shower rain"]="󰖖"
weather_icons["heavy intensity shower rain"]="󰖖"
weather_icons["ragged shower rain"]="󰖖"
weather_icons["light snow"]="󰼶"
weather_icons["snow"]="󰼶"
weather_icons["heavy snow"]="󰼶"
weather_icons["sleet"]="󰙿"
weather_icons["light shower sleet"]="󰙿"
weather_icons["shower sleet"]="󰙿"
weather_icons["light rain and snow"]="󰙿"
weather_icons["rain and snow"]="󰙿"
weather_icons["light shower snow"]="󰙿"
weather_icons["shower snow"]="󰙿"
weather_icons["heavy shower snow"]="󰙿"
weather_icons["mist"]="󰖑"
weather_icons["smoke"]="[smoke]"
weather_icons["haze"]="󰼰"
weather_icons["sand/dust whirls"]="[sand/dust]"
weather_icons["fog"]="󰖑"
weather_icons["sand"]="[sand]"
weather_icons["dust"]="[dust]"
weather_icons["volcanic ash"]="[ash]"
weather_icons["squalls"]="[squall]"
weather_icons["tornado"]="󰼸"
weather_icons["clear sky"]="󰖙"
weather_icons["few clouds"]="󰖕"
weather_icons["scattered clouds"]="󰖕"
weather_icons["broken clouds"]="󰖐"
weather_icons["overcast clouds"]="󰖐"

declare -A weather_icons_night
weather_icons_night["thunderstorm with light rain"]="󰖓"
weather_icons_night["thunderstorm with rain"]="󰖓"
weather_icons_night["thunderstorm with heavy rain"]="󰖓"
weather_icons_night["light thunderstorm"]="󰖓"
weather_icons_night["thunderstorm"]="󰖓"
weather_icons_night["heavy thunderstorm"]="󰖓"
weather_icons_night["ragged thunderstorm"]="󰖓"
weather_icons_night["thunderstorm with light drizzle"]="󰖓"
weather_icons_night["thunderstorm with drizzle"]="󰖓"
weather_icons_night["thunderstorm with heavy drizzle"]="󰖓"
weather_icons_night["light intensity drizzle"]="󰖖"
weather_icons_night["drizzle"]="󰖖"
weather_icons_night["heavy intensity drizzle"]="󰖖"
weather_icons_night["light intensity drizzle rain"]="󰖖"
weather_icons_night["drizzle rain"]="󰖖"
weather_icons_night["heavy intensity drizzle rain"]="󰖖"
weather_icons_night["shower rain and drizzle"]="󰖖"
weather_icons_night["heavy shower rain and drizzle"]="󰖖"
weather_icons_night["shower drizzle"]="󰖖"
weather_icons_night["light rain"]="󰖖"
weather_icons_night["moderate rain"]="󰖖"
weather_icons_night["heavy intensity rain"]="󰖖"
weather_icons_night["very heavy rain"]="󰖖"
weather_icons_night["extreme rain"]="󰖖"
weather_icons_night["freezing rain"]="󰖖"
weather_icons_night["light intensity shower rain"]="󰖖"
weather_icons_night["shower rain"]="󰖖"
weather_icons_night["heavy intensity shower rain"]="󰖖"
weather_icons_night["ragged shower rain"]="󰖖"
weather_icons_night["light snow"]="󰼶"
weather_icons_night["snow"]="󰼶"
weather_icons_night["heavy snow"]="󰼶"
weather_icons_night["sleet"]="󰙿"
weather_icons_night["light shower sleet"]="󰙿"
weather_icons_night["shower sleet"]="󰙿"
weather_icons_night["light rain and snow"]="󰙿"
weather_icons_night["rain and snow"]="󰙿"
weather_icons_night["light shower snow"]="󰙿"
weather_icons_night["shower snow"]="󰙿"
weather_icons_night["heavy shower snow"]="󰙿"
weather_icons_night["mist"]="󰖑"
weather_icons_night["smoke"]="[smoke]"
weather_icons_night["haze"]="󰼰"
weather_icons_night["sand/dust whirls"]="[sand/dust]"
weather_icons_night["fog"]="󰖑"
weather_icons_night["sand"]="[sand]"
weather_icons_night["dust"]="[dust]"
weather_icons_night["volcanic ash"]="[ash]"
weather_icons_night["squalls"]="[squall]"
weather_icons_night["tornado"]="󰼸"
weather_icons_night["clear sky"]="󰖔"
weather_icons_night["few clouds"]="󰼱"
weather_icons_night["scattered clouds"]="󰼱"
weather_icons_night["broken clouds"]="󰖐"
weather_icons_night["overcast clouds"]="󰖐"

function wind_spd_icon() {
	echo "${wind_spd_icons["$1"]}"
}

function wind_dir_icon() {
	echo "${wind_dir_icons["$1"]}"
}

function weather_icon() {
	local DESCRIPTION=$1
	local IS_NIGHT=$2

	if [ "$IS_NIGHT" == "true" ]; then
		echo "${weather_icons_night["$DESCRIPTION"]}"
	else
		echo "${weather_icons["$DESCRIPTION"]}"
	fi
}

function wind_dir() {
	# Convert wind direction from degrees to cardinal direction
	local WIND_DIR=$1

	if [ "$WIND_DIR" -ge 337 ] || [ "$WIND_DIR" -lt 23 ]; then
		echo "N" # just trust me ok
	elif [ "$WIND_DIR" -ge 23 ] && [ "$WIND_DIR" -lt 68 ]; then
		echo "NE"
	elif [ "$WIND_DIR" -ge 68 ] && [ "$WIND_DIR" -lt 113 ]; then
		echo "E"
	elif [ "$WIND_DIR" -ge 113 ] && [ "$WIND_DIR" -lt 158 ]; then
		echo "SE"
	elif [ "$WIND_DIR" -ge 158 ] && [ "$WIND_DIR" -lt 203 ]; then
		echo "S"
	elif [ "$WIND_DIR" -ge 203 ] && [ "$WIND_DIR" -lt 248 ]; then
		echo "SW"
	elif [ "$WIND_DIR" -ge 248 ] && [ "$WIND_DIR" -lt 293 ]; then
		echo "W"
	else
		echo "NW"
	fi
}

function beaufort() {
	# Converts m/s to bft
	local SPEED=$1

	if (( $(echo "$SPEED < 0.2" | bc -l) )); then
		echo "0"
	elif (( $(echo "$SPEED < 1.5" | bc -l) )); then
		echo "1"
	elif (( $(echo "$SPEED < 3.3" | bc -l) )); then
		echo "2"
	elif (( $(echo "$SPEED < 5.4" | bc -l) )); then
		echo "3"
	elif (( $(echo "$SPEED < 7.9" | bc -l) )); then
		echo "4"
	elif (( $(echo "$SPEED < 10.7" | bc -l) )); then
		echo "5"
	elif (( $(echo "$SPEED < 13.8" | bc -l) )); then
		echo "6"
	elif (( $(echo "$SPEED < 17.1" | bc -l) )); then
		echo "7"
	elif (( $(echo "$SPEED < 20.7" | bc -l) )); then
		echo "8"
	elif (( $(echo "$SPEED < 24.4" | bc -l) )); then
		echo "9"
	elif (( $(echo "$SPEED < 28.4" | bc -l) )); then
		echo "10"
	elif (( $(echo "$SPEED < 32.6" | bc -l) )); then
		echo "11"
	else
		echo "12"
	fi
}

# Get and format weather data
WEATHER_JSON=$(curl -s https://api.openweathermap.org/data/2.5/weather?lat=$LAT\&lon=$LON\&units=metric\&appid=$API_KEY)

# Figure out if it's night or not
NOW=$(date +%s)
SUNRISE=$(jq -r '.sys.sunrise' <<<"$JSON")
SUNSET=$(jq -r '.sys.sunset' <<<"$JSON")

if (( NOW < SUNRISE || NOW > SUNSET )); then
	IS_NIGHT="false"
else
	IS_NIGHT="true"
fi

# Get icon
WEATHER_DESC=$(echo "$WEATHER_JSON" | jq -r '.weather[0].description')
WEATHER_ICON=$(weather_icon "$WEATHER_DESC" "$IS_NIGHT")

TEMP=$(echo "$WEATHER_JSON" | jq -r '.main.temp')
TEMP_FMT=$(printf "%.0f" "$TEMP")

echo "  $WEATHER_ICON   $TEMP_FMT°  "

# Maybe I want these later but nah not for now
# HUMIDITY=$(echo "$WEATHER_JSON" | jq -r '.main.humidity')

# WIND_SPD=$(echo "$WEATHER_JSON" | jq -r '.wind.speed')
# WIND_SPD_BFT=$(beaufort "$WIND_SPD")

# WIND_DIR=$(echo "$WEATHER_JSON" | jq -r '.wind.deg')
# WIND_DIR_CARDINAL=$(wind_dir "$WIND_DIR")

# # echo "$WEATHER_ICON   $TEMP_FMT° $HUMIDITY%  $WIND_DIR_CARDINAL $WIND_SPD_BFT"
