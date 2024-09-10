#!/bin/zsh
# Replace Lando site URL and name
read "site_name?What is the machine name of your local site? [$(basename "$PWD")]: "
site_name=${site_name:-$(basename "$PWD")}

#Composer and site profile install
lando composer update
lando drush si local_drupal_dev_profile --db-url=mysql://drupal10:drupal10@database:3306/drupal10 -y

# set site name
site_title="$(print -r -- ${(C)site_name})"
site_title="${site_title//-/ }"
lando drush cset system.site name "$site_title" -y

# Cleanup
lando drush cr
lando drush uli
