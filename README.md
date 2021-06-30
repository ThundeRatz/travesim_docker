<h1 align="center">🥅 TraveSim Docker 🐋</h1>
<p align="center">Docker configurations for TraveSim and TraveSim Adapters</p>

<p align="center">

<img src="https://img.shields.io/badge/ROS%20version-noetic-informational?style=for-the-badge" href="http://wiki.ros.org/noetic"/>
<img src="https://img.shields.io/badge/Gazebo%20version-11-important?style=for-the-badge" href="http://gazebosim.org/"/>

</p>

## 🎈 Intro

This is a Docker image build around [TraveSim](https://github.com/ThundeRatz/travesim) and [TraveSim adapters](https://github.com/ThundeRatz/travesim_adapters)

## 📦 Dependencies

The best way to run this image is with [rocker](https://github.com/osrf/rocker), ROS custom docker runner.

If you have ROS repos configured in your computer (see [here](http://wiki.ros.org/noetic/Installation/Ubuntu#Installation.2FUbuntu.2FSources.Configure_your_Ubuntu_repositories) how to do that), you may install `rocker` with the command

```bash
sudo apt-get install python3-rocker
```

If you don't have the ROS repos or you don't use a Debian-based distro, you may also install `rocker` with `pip`

```bash
python -m pip install rocker
```

## 🏁 Run

### 🤖 rocker

For Intel integrated graphics cards:

```bash
rocker --devices /dev/dri/card0 --x11 --network host ghcr.io/thunderatz/travesim_pkg:stable
```

For NVidia GPUs:

```bash
rocker --nvidia --x11 --network host ghcr.io/thunderatz/travesim_pkg:stable
```

### 🐋 docker

Running on linux:

```bash
docker run -it --rm \
    --env="DISPLAY" \
    --env="TERM" \
    --env="QT_X11_NO_MITSHM=1" \
    --env="XAUTHORITY=/tmp/.docker.xauth" \
    --volume /tmp/.docker.xauth:/tmp/.docker.xauth \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --network host \
    ghcr.io/thunderatz/travesim_pkg:stable
```

### 🔧 Options

The container accepts two enviroment variables as running options. To pass enviroment variables to docker or rocker use the option `--env NAME[=VALUE] [NAME[=VALUE] ...]` or `-e NAME[=VALUE] [NAME[=VALUE] ...]`.

#### 🚸 Graphical User Interface

There are two avaible graphical interfaces, TraveSim's gazebo interface and TraveSim Adapters configurers interface. The configurers' interface is always shown, but gazebo in TraveSim can run headless. To do so use the `GUI` option, values can be 0 or 1, default is 1, so the default is to show both GUIs.

For example using rocker:

```bash
rocker --devices /dev/dri/card0 --env GUI=0 --x11 --network host ghcr.io/thunderatz/travesim_pkg:stable
```

For example using docker on linux:

```bash
docker run -it --rm \
    --env="DISPLAY" \
    --env="TERM" \
    --env="QT_X11_NO_MITSHM=1" \
    --env="XAUTHORITY=/tmp/.docker.xauth" \
    --env="GUI=0" \
    --volume /tmp/.docker.xauth:/tmp/.docker.xauth \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --network host \
    ghcr.io/thunderatz/travesim_pkg:stable
```

#### 🔢 Robots per team

Travesim support games with three or five robots per team. To choose the configuration use the `ROBOTS_PER_TEAM` option, passing the number of robots per team, values can be 3 or 5, default is 3.

For example using rocker:

```bash
rocker --devices /dev/dri/card0 --env ROBOTS_PER_TEAM=5 --x11 --network host ghcr.io/thunderatz/travesim_pkg:stable
```

For example using docker on linux:

```bash
docker run -it --rm \
    --env="DISPLAY" \
    --env="TERM" \
    --env="QT_X11_NO_MITSHM=1" \
    --env="XAUTHORITY=/tmp/.docker.xauth" \
    --env="ROBOTS_PER_TEAM=5" \
    --volume /tmp/.docker.xauth:/tmp/.docker.xauth \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --network host \
    ghcr.io/thunderatz/travesim_pkg:stable
```
