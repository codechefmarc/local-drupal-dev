#!/bin/zsh
# Replace Lando site URL and name.
read "site_name?What is the machine name of your local site? [$(basename "$PWD")]: "
site_name=${site_name:-$(basename "$PWD")}
sed -i '' "s/local-drupal-dev/$site_name/g" .lando.yml

# Change origin of git repo.
read "git_url?What is the git URL for this new site? [git@github.com:codechefmarc/$site_name.git]: "
git_url=${git_url:-"git@github.com:codechefmarc/$site_name.git"}
git remote set-url origin $git_url

# Add original repo to be able to more easily get updates.
git remote add original git@github.com:codechefmarc/local-drupal-dev.git

# Lando init.
lando rebuild -y
lando start

#Composer and site pofile install.
lando composer install
lando drush si local_drupal_dev_profile --db-url=mysql://drupal10:drupal10@database:3306/drupal10 -y

# set site name.
site_title="$(print -r -- ${(C)site_name})"
site_title="${site_title//-/ }"
lando drush cset system.site name "$site_title" -y

# Cleanup.
lando drush cr
lando drush uli
