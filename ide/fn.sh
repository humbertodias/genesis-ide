#!/bin/bash

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