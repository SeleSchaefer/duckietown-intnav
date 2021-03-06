#!/bin/bash

MY_IP=$(hostname -I | cut -d " " -f 1)
export ROS_IP=${MY_IP}
echo "Setting ROS_IP to host IP, which is $ROS_IP"

if [ ! -z "$DUCKIEBOT_NAME" ] && [ ! -z "$DUCKIEBOT_IP" ]; then # We are running on the Desktop
    duckiebot_binding="$DUCKIEBOT_IP $DUCKIEBOT_NAME $DUCKIEBOT_NAME.local"
    echo "Writing \"$duckiebot_binding\" into /etc/hosts"
    echo $duckiebot_binding >> /etc/hosts
    export ROS_MASTER_URI="http://$DUCKIEBOT_NAME.local:11311/"
else # We are running on the Duckiebot, which can always reach itself
    export ROS_MASTER_URI="http://localhost:11311/"
fi

source /home/software/environment.sh
export DUCKIEFLEET_ROOT=/data/config
export VEHICLE_NAME=$HOSTNAME
cat /home/software/misc/duckie.art

/home/software/docker/init_config_defaults.sh

cd /home/software/catkin_ws/src/duckietown-intnav/lib-intnav
python setup.py develop --no-deps
cd /home/software
