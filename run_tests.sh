#!/usr/bin/env bash

set -ev

[[ ! -d "/test-module" ]] && cp -rT /src /test-module

cd /test-module

# Remove .git files from vendor.
[[ -d "./vendor" ]] && find ./vendor -type d | grep .git | xargs rm -rf

# Remove all untracked files.
[[ -d "./.git" ]] && git clean -dfx

mkdir -p /var/www/html/
/pareviewsh/pareview.sh /test-module > /var/www/html/index.html

cat /var/www/html/index.html
sha1sum /var/www/html/index.html | grep f0a3c8e025995b6c47792e3079fbaae076210d6b
