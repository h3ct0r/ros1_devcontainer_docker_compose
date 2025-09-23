#!/bin/bash

source /opt/ros/$ROS_DISTRO/setup.bash

mkdir -p /home/ubuntu/ros_ws/src
sudo chown -R $(whoami) /home/ubuntu/

cd /home/ubuntu/ros_ws/

sudo rosdep install --from-paths /home/ubuntu/ros_ws/src --ignore-src -y

catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release
catkin build