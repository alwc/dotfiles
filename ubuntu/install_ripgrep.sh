#!/bin/bash
#
# Modified from: https://gist.github.com/demosten/bdbc4f07c2ddbea0b8f0ad50a98ae5ff
# This is needed because linuxbrew can't install the latest `ripgrep`
# Read: https://github.com/Homebrew/linuxbrew-core/issues/19885
#
# Install specific version of a Homebrew formula
#
# Usage: brewv.sh formula_name desired_version
#
# Notes:
# - this will unshallow your brew repo copy. It might take some time the first time
#   you call this script
# - it will uninstall (instead of unlink) all your other versions of the formula.
#   Proper version management is out of scope of this script. Feel free to improve.
# - my "git log" uses less by default and when that happens it breaks the script
#   Therefore we have the "--max-count=20" parameter. This might fail to find proper
#   version if the one you wish to install is outside of this count.
#
# Author: Stanimir Karoserov ( demosten@gmail.com )

PKG_NAME=ripggrep
VERSION=11.0.2

git -C "$(brew --repo homebrew/core)" fetch --unshallow || echo "Homebrew repo already unshallowed"
commit=$(brew log --max-count=20 --oneline ${PKG_NAME}|grep ${VERSION}| head -n1| cut -d ' ' -f1)
formula=$(brew log --max-count=20 --oneline ${PKG_NAME}|grep ${VERSION}| head -n1| cut -d ':' -f1|cut -d ' ' -f2)

if [ -z ${commit} ] || [ -z ${formula} ]; then
	echo "No version matching '${VERSION}' for '${PKG_NAME}'"
	exit 1
else
	cd /usr/local/bin
	if [[ -e $formula ]]; then
		brew uninstall --force ${PKG_NAME}
	fi
	brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/$commit/Formula/$formula.rb

	echo "${PKG_NAME} ${VERSION} installed."
fi

