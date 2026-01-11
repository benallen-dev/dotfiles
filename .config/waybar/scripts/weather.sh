#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/weather.sh.config" 2>/dev/null

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

echo "$WEATHER_ICON   $TEMP_FMT°"

