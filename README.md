# dash-deploy
rapid dashbboard deployment on Raspberry Pi 

##get started

ssh login to raspberry and clone the repository
```
ssh -l pi raspberrypi.local
git clone https://github.com/ebirn/dash-deploy
```
Now form within the cloned directory `dash-deploy`

Install required software packages: mostly X server, fonts, browser
The list of packages was obtained by `dpkg --get-selections`
```
#cat installed-packages.txt | sudo dpkg --set-selections
apt-get install $(awk '{print $1;}' installed-packages.txt  | tr \\n ' ')
```
Maybe follow up with a package update and reboot the system for good measure (and new kernels)
```
sudo apt-get update
sudo apt-get upgrade
sudo rpi-update

# patch fstab
sudo sh -c 'cat tmpfs.fstab >> /etc/fstab'

# disable swap
sudo dphys-swapfile swapoff

# journal on tmpfs
sudo sh -c 'echo "Storage=volatile" >> /etc/systemd/journald.conf'

# allow any user to start X
sudo sed -i 's/console/anybody/' /etc/X11/Xwrapper.config

# noswap kernel cmdline
sudo sed -i ' 1 s/.*/& noswap/' /boot/cmdline.txt 
sudo apt-get remove dphys-swapfile

# cleanup 
sudo apt-get autoremove


sudo reboot
```

## prepare ~/.xinitrc
```
cp xinitrc ~/.xinitrc
```
set variable `DASHBOARD_URL` in `~/.xinitrc` to the website that yould be used as dashboard
i.e. your Grafana Dasboad Playlist, Kibana Dashboard, etc.

## configure system services
```
sudo addgroup pi tty
sudo cp dashboard.service  /etc/systemd/system/dashboard.service
sudo systemctl daemon-reload
sudo systemctl enable dashboard.service
sudo systemctl start dashboard.service
```
The raspberry Pi will start the graphical user interface in fullscreen 
and load the dashboard website - also when rebooting the device

Enjoy the new insights :sunglasses:



