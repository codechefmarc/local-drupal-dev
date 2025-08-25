#!/bin/zsh
# Replace Lando site URL and name.
read "site_name?What is the machine name of your local site? [$(basename "$PWD")]: "
site_name=${site_name:-$(basename "$PWD")}
sed -i '' "s/^name: .*/name: $site_name/" .ddev/config.yaml

# Change origin of git repo.
read "git_url?What is the git URL for this new site? [git@github.com:codechefmarc/$site_name.git]: "
git_url=${git_url:-"git@github.com:codechefmarc/$site_name.git"}
git remote set-url origin $git_url

# Add original repo to be able to more easily get updates.
git remote add original git@github.com:codechefmarc/local-drupal-dev.git

# Ddev init.
ddev start

#Composer, install drupal and recipe.
ddev composer install
ddev drush site:install --account-name=admin --account-pass=admin -y
ddev drush recipe ../recipes/local-drupal-dev

# set site name.
site_title="$(print -r -- ${(C)site_name})"
site_title="${site_title//-/ }"
lando drush cset system.site name "$site_title" -y

# Cleanup.
lando drush cr
lando drush uli
