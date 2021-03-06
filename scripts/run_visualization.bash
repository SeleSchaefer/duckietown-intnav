# /bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: bash run_visualization.bash DUCKIEBOT"
    exit 1
fi
DUCKIEBOT="$1"
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

source $SCRIPTPATH/../../../devel/setup.bash
source $SCRIPTPATH/connect_roscore.bash $DUCKIEBOT
source $SCRIPTPATH/rviz_config.bash $DUCKIEBOT
roslaunch duckietown-intnav visualization.launch duckiebot:=$DUCKIEBOT 