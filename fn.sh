#!/bin/bash

# https://github.com/libretro/RetroArch/tree/master/pkg/emscripten
# https://buildbot.libretro.com/stable/
install_retroarch_web() {
	TYPE=$1
	VERSION=$2
	ROOT_WWW_PATH=$3

	URL=https://buildbot.libretro.com/stable/${VERSION}/emscripten/RetroArch.7z
	if [ $TYPE != "stable" ]; then
		URL=https://buildbot.libretro.com/nightly/emscripten/${VERSION}_RetroArch.7z
	fi

	cd ${ROOT_WWW_PATH} &&
		curl -o RetroArch.7z -L "$URL" &&
		7z x -y RetroArch.7z &&
		mv retroarch/* . &&
		rmdir retroarch &&
		sed -i '/<script src="analytics.js"><\/script>/d' ./index.html &&
		chmod +x indexer &&
		cd ${ROOT_WWW_PATH}/assets/frontend/bundle &&
		../../../indexer >.index-xhr &&
		cd ${ROOT_WWW_PATH}/assets/cores &&
		../../indexer >.index-xhr &&
		rm -rf ${ROOT_WWW_PATH}/RetroArch.7z
}

install_vscode_extension(){
    PUBLISHER=$1
    NAME=$2
    VERSION=$3
    URL="http://${PUBLISHER}.gallery.vsassets.io/_apis/public/gallery/publisher/${PUBLISHER}/extension/${NAME}/${VERSION}/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"
    DIR=$(mktemp -d)
    cd $DIR \
    && curl -o ext.vsix -L "$URL" \
    && code-server --install-extension ext.vsix
    rm -rf $DIR
}

function install_emsdk() {
	cd /opt &&
		# Get the emsdk repo
		git clone https://github.com/emscripten-core/emsdk.git &&
		# Enter that directory
		cd emsdk &&
		# Fetch the latest version of the emsdk (not needed the first time you clone)
		git pull &&
		# Download and install the latest SDK tools.
		./emsdk install latest &&
		# Make the "latest" SDK "active" for the current user. (writes .emscripten file)
		./emsdk activate latest
	# Activate PATH and other environment variables in the current terminal
	echo "source /opt/emsdk/emsdk_env.sh" >> ~/.profile
}