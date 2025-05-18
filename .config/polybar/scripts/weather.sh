#!/usr/bin/env bash

# Honestly this feels like one of those times where I should be reaching for
# an actual programming language, but the convention for polybar modules is to
# use shell scripts, so I'm just gonna challenge myself

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/weather.sh.secret"
source "$SCRIPT_DIR/weather.sh.functions"
source "$SCRIPT_DIR/weather.sh.config" 2>/dev/null

# weather.sh.config stores fetched LAT and LON values
# if it does not exist, the openweathermap geocoding API is used to fetch
# the lat and lon values for the given city
if [ -z "$LAT" ] || [ -z "$LON" ]; then
	# If LAT and LON are not set, use the OpenWeatherMap geocoding API to get them
	LOCATION=Delft,NL

	# Fetch the latitude and longitude for the given location, and store it
	eval "$(curl -s https://api.openweathermap.org/geo/1.0/direct?q=$LOCATION\&appid=$API_KEY | jq -r '.[0] | "LAT=\(.lat)\nLON=\(.lon)"')"
	echo "LAT=$LAT" >./weather.sh.config
	echo "LON=$LON" >>./weather.sh.config
fi

WEATHER_JSON=$(curl -s https://api.openweathermap.org/data/2.5/weather?lat=$LAT\&lon=$LON\&units=metric\&appid=$API_KEY)

WEATHER=$(echo "$WEATHER_JSON" | jq -r '.weather[0].main')
WEATHER_DESC=$(echo "$WEATHER_JSON" | jq -r '.weather[0].description')
TEMP=$(echo "$WEATHER_JSON" | jq -r '.main.temp')
HUMIDITY=$(echo "$WEATHER_JSON" | jq -r '.main.humidity')
WIND_SPEED=$(echo "$WEATHER_JSON" | jq -r '.wind.speed')
WIND_DIR=$(echo "$WEATHER_JSON" | jq -r '.wind.deg')

TEMP_FMT=$(printf "%.0f" "$TEMP")
WIND_DIR_FMT=$(wind_dir "$WIND_DIR")
WIND_SPD_FMT=$(beaufort "$WIND_SPEED")

# Print the weather information (in weather-icons font)
OUT="%{T1}$WEATHER ($WEATHER_DESC), $TEMP_FMT°C $HUMIDITY%, %{T3}$WIND_DIR_FMT $WIND_SPD_FMT "
echo "$OUT"
