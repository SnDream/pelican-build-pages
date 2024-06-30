#!/bin/bash

####################################################################################################
#
# Calls github-pages executable to build the site using allowed plugins and supported configuration
#
####################################################################################################

SOURCE_DIRECTORY=${GITHUB_WORKSPACE}/$INPUT_SOURCE
DESTINATION_DIRECTORY=${GITHUB_WORKSPACE}/$INPUT_DESTINATION
THEME_DIRECTORY=${GITHUB_WORKSPACE}/$INPUT_THEME
CONFIG_FILE=${GITHUB_WORKSPACE}/$INPUT_CONFIGFILE

set -e

echo 'Installing 🐍 Python Requirements'
pip install -r requirements.txt

if [ -n "${INPUT_THEME}" ]; then
  echo 'Installing Node Modules 🧰 '
  pushd "${THEME_DIRECTORY}"
  npm install
  popd
fi

echo 'Building site 👷 '
pelican "${SOURCE_DIRECTORY:=content}" -s "${CONFIG_FILE:=publishconf.py}" -o "${DESTINATION_DIRECTORY:=output}"
