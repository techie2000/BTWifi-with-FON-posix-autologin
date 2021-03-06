# BTWifi-with-FON-posix-autologin
A posix compliant (?) sh script to autologin to BTWifi-with-FON instead of having to constantly enter user/pw details. 

This was put together by me based on https://gist.github.com/sscarduzio/05ed0b41d6234530d724#gistcomment-3212135 which detailed a bash script to do similar for btopenzone, and has been designed for use on a GL-AR750S-730 running OpenWRT when I'm visiting various locations that need more data than I reasonably have available through my phone's mobile data hotspot.  

Not being a sh guru, help in the conversion was gleaned from 
* https://unix.stackexchange.com/a/554680

Note
* wget on the GL-AR750S-730 doesn't support the --no-cache option. I've not run into any issues (yet) by ommitting it
* iwgetid on the GL-AR750S-730 is unsupported (and depricated?), so tweaked to use iw and a suitable grep to return the expected info 

Modified script has passed the scrupulous eye of https://www.shellcheck.net/

You will need to change these lines with your own details
*  RELOG_UNAME="<username>"
*  RELOG_PASSW="<pass>"
  
and extend the 
*  supportedssid

rows as needed to detail the specifics of your SSID

I choose to create a `scripts` folder under `/usr/share/` and put the main script in there.

Note, if you are running this on a virgin device, you will need to turn-off 'DNS Rebinding Attack Protection' which is on by default - this can be found under `More Settings / Custom DNS Server`

I run cron to perform checks/restart every 5mins, and to run regular ping in an attempt to keep the connection open. Note, I think they BT force a disconnect every 2hours and so you are forced to reconnect.

> crontab -e 

This will open /etc/crontabs/root file in vi where you can add something like

> #### Check we are connected to BTWifi-with_FON every 5mins and reconnect if not
> */5 * * * * /usr/share/scripts/BTWifi-with-FON_login.sh
> 
> #### Run a ping every minute for 5secs in an attempt to prevent BTWifi-with-FON from disconnecting
> */1 * * * * /bin/ping -w 5 www.google.com
