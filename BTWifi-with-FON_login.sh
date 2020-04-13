#!/bin/sh
#CONF
DBG=true
RELOG_UNAME="<username>"
RELOG_PASSW="<pass>"

#FUNCTION TO CONNECT
connect_to_wifi () {
  IS_LOGGED_IN=$(wget "https://www.btwifi.com:8443/home" --no-check-certificate --timeout 15 -O - 2>/dev/null | grep "now logged in")

  if [ "$IS_LOGGED_IN" ]

  then
    $DBG && echo "Currently logged in. Nothing to do... :)"
    $DBG && logger -t "logon_fon" "Currently logged in. Nothing to do... :)"

  else
    $DBG && echo "You're not logged in... will log in now!"
    $DBG && logger -t "logon_fon" "You're not logged in... will log in now!"
    OUT=$(wget -qO - --no-check-certificate --post-data "provider=tbb& username=$RELOG_UNAME&password=$RELOG_PASSW" "https://www.btwifi.com:8443/home")
    ONLINE=$(echo "$OUT" | grep "now logged on" )
    if [ "$ONLINE" ]
    then
      $DBG && echo "You're online!"
      $DBG && logger -t "logon_fon" "You're online!"
    else
      $DBG && echo "Could not login :("
      $DBG && logger -t "logon_fon" "Could not login :("
    fi
  fi
}

#GET CURRENT WIFI
myssid=$(iw dev wlan1 info | grep ssid)
#sh doesn't support arrays, so simulate an ARRAY CONTAINING SUPPORTED WIFI NETWORKS
supportedssid=""
supportedssid="$supportedssid BTWifi-with-FON"
supportedssid="$supportedssid BTWi-fi"
supportedssid="$supportedssid GL-AR750S-730"


#IF NETWORK IS SUPPROTED, ATTEMPT TO CONNECT
if [ "${supportedssid##*$myssid*}" ]
then
  echo "Connected to a BT wifi net: will try to log in"
  connect_to_wifi
else
  echo "Wifi is $myssid"
fi
