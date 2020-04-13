# BTWifi-with-FON-posix-autologin
A posix compliant sh script to autologin to BTWifi-with-FON instead of having to constantly enter user/pw details.  

This was put together by me based on https://gist.github.com/sscarduzio/05ed0b41d6234530d724#gistcomment-3212135 which detailed a bash script to do similar for btopenzone, and designed for use on a GL-AR750S-730 running OpenWRT when I'm visiting various locations that need more data than I reasonably have available through my phone's monile hotspot.  

You will need to change these lines with your own details
*  RELOG_UNAME="<username>"
*  RELOG_PASSW="<pass>"
  
and extend the 
*  supportedssid

rows as needed to detail the specifics of your SSID