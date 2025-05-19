#!/usr/bin/env bash

# Honestly this feels like one of those times where I should be reaching for
# an actual programming language, but the convention for polybar modules is to
# use shell scripts, so I'm just gonna challenge myself

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/weather.sh.secret"
source "$SCRIPT_DIR/weather.sh.functions"

# weather.sh.config stores fetched LAT and LON values
# If it does not exist, the openweathermap geocoding API is used to fetch
# the lat and lon values for the given city
source "$SCRIPT_DIR/weather.sh.config" 2>/dev/null
if [ -z "$LAT" ] || [ -z "$LON" ]; then
	# If LAT and LON are not set, use the OpenWeatherMap geocoding API to get them

	LOCATION=Delft,NL # If you change this, delete ./weather.sh.config

	# Fetch the latitude and longitude for the given location, and store it
	eval "$(curl -s https://api.openweathermap.org/geo/1.0/direct?q=$LOCATION\&appid=$API_KEY | jq -r '.[0] | "LAT=\(.lat)\nLON=\(.lon)"')"
	echo "LAT=$LAT" >./weather.sh.config
	echo "LON=$LON" >>./weather.sh.config
fi

# Get and format weather data
WEATHER_JSON=$(curl -s https://api.openweathermap.org/data/2.5/weather?lat=$LAT\&lon=$LON\&units=metric\&appid=$API_KEY)

WEATHER_DESC=$(echo "$WEATHER_JSON" | jq -r '.weather[0].description')
WEATHER_ICON=$(weather_icon "$WEATHER_DESC")

TEMP=$(echo "$WEATHER_JSON" | jq -r '.main.temp')
TEMP_FMT=$(printf "%.0f" "$TEMP")
HUMIDITY=$(echo "$WEATHER_JSON" | jq -r '.main.humidity')

WIND_SPD=$(echo "$WEATHER_JSON" | jq -r '.wind.speed')
WIND_SPD_BFT=$(beaufort "$WIND_SPD")

WIND_DIR=$(echo "$WEATHER_JSON" | jq -r '.wind.deg')
WIND_DIR_CARDINAL=$(wind_dir "$WIND_DIR")

echo "$WEATHER_ICON $TEMP_FMT° $HUMIDITY%  $WIND_DIR_CARDINAL $WIND_SPD_BFT"
