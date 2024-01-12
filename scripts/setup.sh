# Change origin of git repo
read -p "What is the git URL for this new site? [git-url]: " git_url
git_url=${git_url:-git-url}
git remote set-url origin $git_url

# Replace Lando site URL and name
read -p "What is the machine name of your local site? [site-name]: " site_name
site_name=${site_name:-site-name}
sed -i '' "s/local-drupal-dev/$site_name/g" .lando.yml

# Lando init
lando rebuild -y

#Composer install
lando composer install
