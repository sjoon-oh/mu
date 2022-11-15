#!/bin/bash
# 
# Author: Sukjoon Oh, sjoon@kaist.ac.kr
# Build script.
# 

MU_HOME=""

# Clear all.
# conan remove -f "*"
# conan profile new default --detect
# conan profile update settings.compiler.libcxx=libstdc++11 default


if [[ $# -eq 0 ]] ; then
    echo 'No argument: Set the working directory.'
    exit 1
else
    MU_HOME=$1
fi

#
# This is the commandline from the original README.
# Internal Field Seperator: ,
declare -a MU_BUILD_CMDS=(
    "${MU_HOME}/build.py crash-consensus",
    "${MU_HOME}/crash-consensus/libgen/export.sh gcc-release",
    "cp ${MU_HOME}/crash-consensus/libgen/exported/libcrashconsensus.so ${MU_HOME}/crash-consensus/experiments/exported",
    "${MU_HOME}/crash-consensus/demo/using_conan_fully/build.sh gcc-release",
    "${MU_HOME}/crash-consensus/experiments/build.sh",
    "${MU_HOME}/crash-consensus/experiments/liquibook/build.sh"
)

IFS=,
for cmd in ${MU_BUILD_CMDS[@]} ;
do
    ${cmd}
    wait
done

