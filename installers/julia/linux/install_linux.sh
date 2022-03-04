#!/bin/bash

## ------------------------------------------------------------------
# TODO use install-julia script
# variables
HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
JULIA_FULL_VERSIONS=(1.0.5 1.5.3)
BIN_FOLDER=${HOME}/.local/bin
SOURCE_FOLDER=${HOME}/bin
TEMP_FOLDER="${HERE}/temp"

## ------------------------------------------------------------------
# Welcome
echo "This script will install julia"
echo "Any Change I'm in ${HERE} or https://github.com/josePereiro/AutoScripts.git"
echo "julia itself will be copied to: ${SOURCE_FOLDER}"
echo "but a link will be placed at: ${BIN_FOLDER}"
echo "Julia versions to install: "
for JULIA_FULL_VERSION in ${JULIA_FULL_VERSIONS[@]}
do
    echo ${JULIA_FULL_VERSION}
done

## ------------------------------------------------------------------
# Preparing
echo
echo "Preparing"
# Add bin to path (This must be pu in a startup file)
export PATH=${BIN_FOLDER}:${PATH}
echo "${BIN_FOLDER} added to PATH"
cd ${HERE}
if [ ! -d ${BIN_FOLDER} ]; then
    mkdir -p ${BIN_FOLDER}
    echo "${BIN_FOLDER} created!!!"
fi
if [ ! -d ${SOURCE_FOLDER} ]; then
    mkdir -p ${SOURCE_FOLDER}
    echo "${SOURCE_FOLDER} created!!!"
fi
if [ ! -d ${TEMP_FOLDER} ]; then
    mkdir -p ${TEMP_FOLDER}
    echo "${TEMP_FOLDER} created!!!"
fi
cd ${TEMP_FOLDER}
echo "now at: ${pwd}"

## ------------------------------------------------------------------
# Installing
for JULIA_FULL_VERSION in ${JULIA_FULL_VERSIONS[@]}
do

    echo
    echo
    echo -------------------------------------------------------
    echo "Installing julia ${JULIA_FULL_VERSION}"
    echo -------------------------------------------------------
    echo

    JULIA_MAJOR_VERSION=${JULIA_FULL_VERSION:0:3}
    # download
    JULIA_GZ_FILE="julia-${JULIA_FULL_VERSION}-linux-x86_64.tar.gz"
    JULIA_URL="https://julialang-s3.julialang.org/bin/linux/x64/${JULIA_MAJOR_VERSION}/${JULIA_GZ_FILE}"
    if [ ! -f ${JULIA_GZ_FILE} ]; then
        echo "Downloading..."
        wget ${JULIA_URL}
        echo "File ${JULIA_GZ_FILE} created"
    fi
    # unziping
    echo
    echo "Unziping"
    tar zxvf ${JULIA_GZ_FILE}
    UNZIPPED_FOLDER="julia-${JULIA_FULL_VERSION}"

    # moving
    echo
    echo "Moving"
    mv -fv ${UNZIPPED_FOLDER} ${SOURCE_FOLDER}
    
    # install
    echo
    SOURCE_EXE="${SOURCE_FOLDER}/${UNZIPPED_FOLDER}/bin/julia"
    JULIA_CMD=julia-${JULIA_FULL_VERSION}
    JULIA_LINK=${BIN_FOLDER}/${JULIA_CMD}
    ln -sf ${SOURCE_EXE} ${JULIA_LINK}
    echo "link created as: ${JULIA_LINK}"

    # Test installation
    echo
    echo "Testing installation"
    ${JULIA_CMD} --startup-file=no -e '@info("Hi from julia ", VERSION)'

    echo
    echo "Adding basic packages"
    ${JULIA_CMD} --startup-file=no ../utils/add_base_packages.jl

done

# post-installation
echo
cd ${HERE}
rm -fdr ${TEMP_FOLDER}
echo "Temp folder removed"

echo "done"