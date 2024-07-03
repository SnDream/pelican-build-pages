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

echo 'Git safe.directory config👷 '
export GIT_CONFIG_COUNT='1'
export GIT_CONFIG_KEY_0='safe.directory'
export GIT_CONFIG_VALUE_0='*'

echo 'Building site 👷 '
pelican "${SOURCE_DIRECTORY:=content}" -s "${CONFIG_FILE:=pelicanconf.py}" -o "${DESTINATION_DIRECTORY:=output}"
