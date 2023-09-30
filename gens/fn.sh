#!/bin/bash

function install_emsdk() {
	VERSION=$1
	cd /opt &&
		# Get the emsdk repo
		git clone https://github.com/emscripten-core/emsdk.git &&
		# Enter that directory
		cd emsdk &&
		# Fetch the latest version of the emsdk (not needed the first time you clone)
		git pull &&
		# Download and install the latest SDK tools.
		./emsdk install $VERSION &&
		# Make the "latest" SDK "active" for the current user. (writes .emscripten file)
		./emsdk activate $VERSION
	# Activate PATH and other environment variables in the current terminal
	echo "source /opt/emsdk/emsdk_env.sh" >> ~/.profile
}