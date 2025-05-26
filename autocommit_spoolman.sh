#!/bin/bash
cd /home/pi/.local/share/spoolman || exit
git add .
git commit -m "Autocommit Spoolman database from $(date +"%Y-%m-%d %H:%M:%S")"
git push origin master
