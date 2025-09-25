#!/bin/bash

source /opt/ros/$ROS_DISTRO/setup.bash

mkdir -p /home/ubuntu/ros_ws/src
sudo chown -R $(whoami) /home/ubuntu/

cd /home/ubuntu/ros_ws/

# open a new terminal here in vscode
code -r \"$(pwd)\" && code --command workbench.action.terminal.new

sudo rosdep install --from-paths /home/ubuntu/ros_ws/src --ignore-src -y

catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release
catkin build