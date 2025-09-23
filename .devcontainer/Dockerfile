FROM osrf/ros:noetic-desktop-full
ARG USER_UID=1000
ARG USER_GID=$USER_UID

SHELL ["/bin/bash", "-c"]

ENV ROS=/opt/ros/noetic/setup.bash
ENV DEBIAN_FRONTEND=noninteractive
ENV USERNAME=ubuntu
ENV PASSWD=ubuntu
ENV ROS_DISTRO=noetic

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

RUN usermod -aG sudo ubuntu

# install graphic interface
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    xfce4 \
    xfce4-goodies \
    supervisor

# Install additonal packages
RUN apt-get install -y \
    python3-pip \
    python-is-python3 \
    python3-catkin-tools \
    jq \
    ssh \
    neovim \
    git \
    build-essential \
    git python3-colcon-common-extensions \
    python3-colcon-mixin \
    python3-rosdep \
    python3-vcstool \
    wget \
    nano \
    vim \
    iputils-ping \
    net-tools \
    unzip \
    mesa-utils \
    libompl-dev \
    ompl-demos \
    terminator \
    tmux \
    dbus-x11 \
    tree \
    curl \
    nmap \
    tigervnc-standalone-server \
    tigervnc-common \
    supervisor \
    wget \
    curl \
    gosu \
    git \
    sudo \
    python3-pip \
    tini \
    lsb-release \
    locales \
    bash-completion \
    tzdata \
    terminator \
    openssh-server

# Install OpenSSH Server and necessary tools
# Set root password (replace 'your_password' with a strong password)
# Allow root login (optional, but simplifies initial setup)
RUN mkdir /var/run/sshd
RUN echo 'ubuntu:ubuntu' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# noVNC and Websockify
RUN git clone https://github.com/AtsushiSaito/noVNC.git -b add_clipboard_support /usr/lib/novnc
RUN pip install --no-cache-dir git+https://github.com/novnc/websockify.git@v0.10.0
RUN ln -s /usr/lib/novnc/vnc.html /usr/lib/novnc/index.html

# Set remote resize function enabled by default
RUN sed -i "s/UI.initSetting('resize', 'off');/UI.initSetting('resize', 'remote');/g" /usr/lib/novnc/app/ui.js

# Disable crash report
RUN sed -i 's/enabled=1/enabled=0/g' /etc/default/apport 

# install ros packages (fix broken key)
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" \
    > /etc/apt/sources.list.d/ros-latest.list' && \
    wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | sudo apt-key add - && \
    apt update && \
    apt install -y python3-catkin-tools \
    ros-noetic-velodyne \
    ros-noetic-velodyne-description \
    ros-noetic-velodyne-simulator \
    ros-noetic-geographic-info \
    ros-noetic-robot-localization \
    ros-noetic-twist-mux \
    ros-noetic-pointcloud-to-laserscan \
    ros-noetic-sensor-filters \
    ros-noetic-gtsam \
    ros-noetic-realsense2-camera \
    ros-noetic-realsense2-description \
    ros-noetic-gazebo-plugins \
    python3-rosinstall \
    python3-rosinstall-generator \
    python3-wstool \
    python3-catkin-tools \
    python3-osrf-pycommon \
    python3-argcomplete \
    python3-rosdep python3-vcstool \ 
    gnupg2 lsb-release \
    python3-rosinstall \
    python3-rosinstall-generator \
    python3-wstool \
    python3-catkin-tools \
    python3-osrf-pycommon \
    python3-argcomplete \
    python3-rosdep python3-vcstool

# vscode
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && \
    install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg && \
    sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' && \
    rm -f packages.microsoft.gpg

# install depending packages
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y bash-completion \
    less \
    wget \
    language-pack-en \
    code \
    vim-tiny \
    iputils-ping \
    net-tools \
    imagemagick \
    python-dev \
    libsecret-1-dev

# colorize less
RUN lesspipe >> ~/.bashrc && \
    echo "export LESS='-R'" >> ~/.bashrc && \
    echo "export PYGMENTIZE_STYLE='monokai'" >> ~/.bashrc && \
    curl -sSL https://raw.githubusercontent.com/CoeJoder/lessfilter-pygmentize/master/.lessfilter > ~/.lessfilter && \
    chmod 755 ~/.lessfilter

# global vscode config
ADD .devcontainer/.vscode /home/ubuntu/.vscode
RUN ln -s /home/ubuntu/.vscode /home/ubuntu/.vscode-server
ADD .devcontainer/compile_flags.txt /home/ubuntu/compile_flags.txt
RUN sudo chown -R ubuntu:ubuntu /home/ubuntu

# Source ROS environment automatically
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> /home/$USERNAME/.bashrc
RUN echo "source /home/ubuntu/ros_ws/devel/setup.bash" >> /home/$USERNAME/.bashrc

# create logs for supervisor
RUN mkdir -p /var/log/supervisor

# clean all apt packages installed
RUN rm -rf /var/lib/apt/lists/*

# Enable apt-get completion after running `apt-get update` in the container
RUN rm /etc/apt/apt.conf.d/docker-clean

COPY .devcontainer/supervisord_configs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY .devcontainer/supervisord_configs/custom_programs.conf /etc/supervisor/conf.d/custom_programs.conf
COPY .devcontainer/supervisord_configs/code_server.conf /etc/supervisor/conf.d/code_server.conf

COPY .devcontainer/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY .devcontainer/onCreate.sh /onCreate.sh
RUN chmod +x /onCreate.sh

COPY .devcontainer/postCreate.sh /postCreate.sh
RUN chmod +x /postCreate.sh

# install code plugins using the default user
USER $USERNAME
RUN code --install-extension ms-python.python && \
    code --install-extension ms-vscode.cpptools-extension-pack && \
    code --install-extension redhat.vscode-xml

RUN rosdep update
    
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "sudo", "-E", "/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]