#!/bin/zsh
# Replace Lando site URL and name
read "site_name?What is the machine name of your local site? [$(basename "$PWD")]: "
site_name=${site_name:-$(basename "$PWD")}

#Composer and site profile install
ddev composer update
ddev drush site:install --account-name=admin --account-pass=admin -y

# set site name
site_title="$(print -r -- ${(C)site_name})"
site_title="${site_title//-/ }"
ddev drush cset system.site name "$site_title" -y

# Cleanup
ddev drush cr
ddev drush uli
