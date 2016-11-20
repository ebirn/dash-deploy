# copy me to default users ~/.xinitrc
# most likely: /home/pi/.xinitrc

DASHBOARD_URL='https://news.ycombinator.com/'

# hide mousepointer, disable all screensaver / power saver
unclutter  &
xset s off         # don't activate screensaver
xset -dpms         # disable DPMS (Energy Star) features.
xset s noblank     # don't blank the video device

# launch browser on website 
exec chromium-browser \
--kiosk \
--incognito \
--disable-restore-session-state \
--start-maximized \
$DASHBOARD_URL

# you may need these
# --ignore-certificate-errors \
# --disable-web-security \
#
#
