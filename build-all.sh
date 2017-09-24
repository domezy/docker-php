#!/usr/bin/env bash

baseDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source ${baseDir}/.env

if [[ ! -d ${baseDir}/log ]]; then
    mkdir ${baseDir}/log
fi

for tag in ${buildOrder[*]}; do
    logFile="${baseDir}/log/php_${tag}.log"
    rm ${logFile}

    cd ${baseDir}/${tag}
    imageName=pretzlaw/php:${tag}
    docker build --no-cache -t ${imageName} . 2>&1 | tee ${baseDir}/log/php_${tag}.log

#    if [[ "0" != "$PIPESTATUS[0]" ]]; then
#        mv ${logFile} ./php_${tag}.err
#    fi
done

ls *.err
