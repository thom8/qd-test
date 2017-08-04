#!/usr/bin/env bash

set -ev

# codespell
sudo apt-get -y install python-pip
pip install codespell

# eslint
npm install -g eslint

## composer
composer self-update
composer global require drupal/coder
phpcs --config-set installed_paths ~/.composer/vendor/drupal/coder/coder_sniffer

# drupalsecure
git clone --branch master https://git.drupal.org/sandbox/coltrane/1921926.git /drupalsecure_code_sniffs
mkdir -p $(pear config-get php_dir)/PHP/CodeSniffer/Standards
sudo ln -sv /drupalsecure_code_sniffs/DrupalSecure $(pear config-get php_dir)/PHP/CodeSniffer/Standards

# PAReview
git clone --branch 7.x-1.x https://git.drupal.org/project/pareviewsh.git /pareviewsh
chmod +x /pareviewsh/pareview.sh
