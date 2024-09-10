# Local Drupal Dev
This repo is a starting point to quickly spin up a local Drupal development environment that is ready to use for Drupal contributions. It includes:

* Devel
* Admin Toolbar
* [Emulsify](https://www.emulsify.info) tooling - but not Emulsify itself for ease of testing new installs of Emulsify

# Getting Started

1. Clone this repo down to a new folder `git clone git@github.com:codechefmarc/local-drupal-dev.git custom-name-here`
2. Change into the new directory and run `npm run setup`
3. Answer the questions - defaults are provided
4. One of the questions is to change the default git repo for push - this allows you to push any changes made to your own repo

# Refresh Local
1. Run `npm run refresh` to rebuild your local from scratch. This command will also re-run `composer install` as well.

# Retrieve updates from the original repo
1. There is now a git remote called `original` to more easily retrieve updates from the original repo.
2. Run `git pull original main` to get the latest updates into your project.
