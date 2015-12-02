# NGPOD (Nat'l. Geographic Photo of the Day)
---
This script repository scrapes the National Geographic website for the photo of the day.

## Usage

 1. call the script manually. But that's tedious. so do this instead:
 2. set it in your `.bash_profile` if you live your life in terminal sessions or this instead:
 3. crontab:
   ` * /12 * * * ~/path/to/script/ngpod2.sh 2>&1`

## Edit the following items to fit your environment
replace `davidr` with your username in the **osascript** line

you will also need to mod the paths after `cd` to fit your environment

also before running script for the first time, since it may break: do `mkdir -p /path/to/images/dir/ngpics`
