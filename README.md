# ROS1 Noetic VScode devcontainer with docker-compose for *development*
## _A simple way to run ROS1 Noetic for *DEVELOPMENT* using https://containers.dev/_

This repo contains a simple way to delevop locally in a ROS1 Noetic docker container using the VScode [devcontainers](https://containers.dev/). 
A  `development container` (or dev container for short) allows you to use a container as a full-featured development environment. It can be used to run an application, to separate tools, libraries, or runtimes needed for working with a codebase, and to aid in continuous integration and testing.

<details>
<summary> Details of the services in this container </summary>

- ROS1 noetic with a base workspace `/home/ubuntu/ros_ws/`;
- Support for arm64 (jetson orin nano) and amd64 architectures;
- Support for NVIDIA Docker runtime for linux hosts;
- VNC server that allows direct browser access (http://localhost:3080/), so nothing is required to install and use it;
- A `ssh` server, to allow direct access from outside (`ssh ubuntu@localhost -p 3022`);
- A web `vscode` server for easy remote access when deploying it on the robot (http://localhost:3081/);
- Automatic `xcode +` command executed on each attachment for local X forwarding;
- Custom environment and VScode configurations:
  - Open split terminals on launch;
  - Setup all environments variables automatically for running ROS;
  - Automatically open the VNC interface in a ROS tab;
  - Custom .vscode tasks to deploy roscore/rviz;
  - Custom PS1 (terminal shell);
</details>

## Devcontainers installation

- Open folder with VScode using the dev containers plugin (https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## Quick usage

### Start devcontainer on VScode or use `docker compose`

- When the host is a linux-based machine:
```
BUILDKIT_PROGRESS=plain docker compose -f compose_linux_host.yaml up --build
```

- When the host is a macos-based machine:
```
BUILDKIT_PROGRESS=plain docker compose -f compose_macos_host.yaml up --build
```

`BUILDKIT_PROGRESS=plain` helps to visualize step by step output of each of the commands.

### Usage

- VNC: http://localhost:3080
- VScode: http://localhost:3081
- SSH: `ssh ubuntu@localhost -p 3022`
  - user: `ubuntu`
  - pass: `ubuntu`
 
<figure>
  <img src="https://github.com/user-attachments/assets/6c085018-0b43-4f0e-9316-20bac5d0d4c1" alt="Fully loaded interface with the VNC client and multiple terminals on the bottom panel" style="width:70%">
  <figcaption>Fully loaded interface with the VNC client and multiple terminals on the bottom panel.</figcaption>
</figure>

## Know issues

- The live preview opens a terminal with a message "cannot find shell for command XXXX". This can be safely ignored.
- The live preview will show a small box with a message "Please reopen the preview". This is fixed in the newest version of the live preview plugin.

## Links/References:

- https://www.youtube.com/watch?v=dihfA7Ol6Mw
- https://github.com/Tiryoh/docker-ros-desktop-vnc/
- https://github.com/atinfinity/nvidia-egl-desktop-ros2/
- https://www.reddit.com/r/ROS/comments/1gsoebe/dev_using_docker_containers/
- https://github.com/elkuno213/ros2-ws-template
- https://github.com/devrt/ros-devcontainer-vscode/

## License

MIT

**Free Software, Hell Yeah!**
