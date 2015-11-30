#!/bin/bash

# acquire sudo at the beginning
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# unload launch agents
sudo launchctl stop /Library/LaunchDaemons/de.bernhard-baehr.sleepwatcher.plist 2>/dev/null
sudo launchctl unload /Library/LaunchDaemons/de.bernhard-baehr.sleepwatcher.plist 2>/dev/null
launchctl unload ~/Library/LaunchAgents/de.bernhard-baehr.sleepwatcher.plist 2>/dev/null

# remove plist launchagents
sudo rm -f /Library/LaunchDaemons/de.bernhard-baehr.sleepwatcher.plist
rm -f ~/Library/LaunchAgents/de.bernhard-baehr.sleepwatcher.plist

# remove executable and man files
sudo rm -f /usr/local/sbin/sleepwatcher
sudo rm -f /usr/local/share/man/man8/sleepwatcher.8

# download sleepwatcher package, untar, and cd into directory
curl --remote-name "http://www.bernhard-baehr.de/sleepwatcher_2.2.tgz"
tar xvzf sleepwatcher_2.2.tgz 2>/dev/null
cd sleepwatcher_2.2

# create folders necessary for installation
sudo mkdir -p /usr/local/sbin /usr/local/share/man/man8

# move files into installation folders
sudo cp sleepwatcher /usr/local/sbin
sudo cp sleepwatcher.8 /usr/local/share/man/man8

match='<\/array>'
insert='<key>StandardErrorPath<\/key><string>\/var\/log\/screw.you.guys.im.going.gome.log<\/string><key>StandardOutPath<\/key><string>\/var\/log\/screw.you.guys.im.going.gome.log<\/string>'
file='config/de.bernhard-baehr.sleepwatcher-20compatibility.plist'

sudo sed -i "" "s/$match/$match$insert/" $file
xmllint --format $file -o $file

sudo cp $file /Library/LaunchAgents/de.bernhard-baehr.sleepwatcher.plist

sleep 1

# load launch agent
sudo launchctl load -w -F /Library/LaunchAgents/de.bernhard-baehr.sleepwatcher.plist

# create script in local user directory and make them executable
sudo cp ../rc.wakeup /etc/rc.wakeup
sudo chmod +x /etc/rc.wakeup
