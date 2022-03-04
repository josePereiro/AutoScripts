#!/bin/bash
HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd ${HERE}

# Adapted from https://github.com/abelsiqueira/jill/blob/master/jill.sh
for JULIA_VERSION in 1.5.2 1.0.5 
do

    echo
    echo
    echo -------------------------------------------------------
    echo "Installing julia $JULIA_VERSION"
    echo -------------------------------------------------------
    echo

    JULIA_MAJOR=${JULIA_VERSION:0:3}
    # download
    if [ ! -f julia-$JULIA_VERSION-mac64.dmg ]; then
        echo "Downloading..."
        wget https://julialang-s3.julialang.org/bin/mac/x64/$JULIA_MAJOR/julia-$JULIA_VERSION-mac64.dmg
        echo "File $HERE/julia-$JULIA_VERSION-mac64.dmg created"
    fi
    # mount
    MOUNT_POINT=julia-$JULIA_VERSION-mac64
    hdiutil attach julia-$JULIA_VERSION-mac64.dmg -quiet -mount required -mountpoint $MOUNT_POINT

    # install
    INSTALL_PATH=/Applications/julia-$JULIA_MAJOR.app
    echo "julia will be installed here: $INSTALL_PATH"
    EXEC_PATH=$INSTALL_PATH/Contents/Resources/julia/bin/julia
    rm -rdf $INSTALL_PATH
    cp -a $MOUNT_POINT/Julia-$JULIA_MAJOR.app /Applications/

    # create symlink
    LINK_FOLDER=/usr/local/bin
    echo "Links will be added here: $LINK_FOLDER"
    ln -sf $EXEC_PATH $LINK_FOLDER/julia
    echo "Link added: julia"
    ln -sf $EXEC_PATH $LINK_FOLDER/julia-$JULIA_VERSION
    echo "Link added: julia-$JULIA_VERSION"

    # post-installation
    umount $MOUNT_POINT
    rm -f julia-$JULIA_VERSION-mac64.dmg
    echo "File $HERE/julia-$JULIA_VERSION-mac64.dmg removed"

    # Test installation
    echo
    echo "Testing installation"
    source ~/.bashrc
    julia-$JULIA_VERSION --startup-file=no -e '@info("Hi from julia ", VERSION)'

    echo
    echo "Adding basic packages"
    julia-$JULIA_VERSION --startup-file=no ../utils/add_base_packages.jl
done
echo "done"