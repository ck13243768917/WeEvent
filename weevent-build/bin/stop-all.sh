#!/bin/bash
current_path=$(pwd)

if [[ -e ${current_path}/install-all.sh ]];then
   echo "Error operation "
   echo "Current path ${current_path} is source code package,only install path can execute stop-all.sh "
   exit 1
fi

for module in $(ls -l|grep ^d|awk '{print $9}');
do
    if [[ ${module} = "zookeeper" ]];then
        cd ${current_path}/zookeeper/apache-zookeeper-3.6.0-bin/bin/;
        ./zkServer.sh stop;
    fi

    # every directory is a single module
    if [[ ${module} != "lib" && ${module} != "zookeeper" ]];then
        cd ${module};
        ./${module}.sh stop;
    fi

    cd ${current_path}
    sleep 1
done

