#!/bin/bash
echo "[init.bash] start"


function run_server () {
    echo "[init.bash] running server.jar..."
    cd $DATA_DIR
    java -jar -Xmx$XMX server.jar
    exit $?
}


if python3 checkEnvVarExists.py XMX; then
    echo "[init.bash] Xmx size is specified:" $XMX
else
    echo "[init.bash] Xmx size is not specified"
    export XMX="1G"
    echo "[init.bash] Xmx size was set to" $XMX
fi


if python3 checkEnvVarExists.py DATA_DIR; then
    echo "[init.bash] custom data directory specified:" $DATA_DIR
else
    echo "[init.bash] custom data directory is NOT specified"
    export DATA_DIR=/data
    echo "[init.bash] data directory was set to" $DATA_DIR
fi


if python3 checkIsDir.py $DATA_DIR; then
    echo "[init.bash]" $DATA_DIR "is exists"
    if python3 checkFileExists.py $DATA_DIR/server.jar; then
        echo "[init.bash] server.jar found"
        run_server
    else
        echo "[init.bash] server.jar not found"
    fi
else
    echo "[init.bash]" $DATA_DIR "is NOT exists"
    if mkdir $DATA_DIR; then
        echo "[init.bash]" $DATA_DIR "created"
    else
        echo "[init.bash] ERROR: cant create" $DATA_DIR
        exit 1
    fi
fi


if python3 checkEnvVarExists.py URL; then
    echo "[init.bash] custom url specified:" $URL
else
    echo "[init.bash] custom url is NOT specified"
    export URL="https://launcher.mojang.com/v1/objects/3cf24a8694aca6267883b17d934efacc5e44440d/server.jar"
    echo "[init.bash] url was set to" $URL
fi


curl $URL --output $DATA_DIR/server.jar


echo "[init.bash] copying server.properties and eula to" $DATA_DIR
cp /app/server.properties $DATA_DIR
cp /app/eula.txt $DATA_DIR


run_server