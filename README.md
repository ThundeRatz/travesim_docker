<h1 align="center">🥅 TraveSim Docker 🐋</h1>
<p align="center">Docker configurations for TraveSim and TraveSim Adapters</p>

<p align="center">

<img src="https://img.shields.io/badge/ROS%20version-noetic-informational?style=for-the-badge" href="http://wiki.ros.org/noetic"/>
<img src="https://img.shields.io/badge/Gazebo%20version-11-important?style=for-the-badge" href="http://gazebosim.org/"/>

</p>

## 🎈 Intro

This is a Docker image build around [TraveSim](https://github.com/ThundeRatz/travesim) and [TraveSim adapters](https://github.com/ThundeRatz/travesim_adapters)

## 🌐 Net settings

The configs are the same as [TraveSim adapters default values](https://github.com/ThundeRatz/travesim_adapters/blob/develop/config/network.yml)

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

For Intel integrated graphics cards

```bash
rocker --devices /dev/dri/card0 --x11 --network host ghcr.io/thunderatz/travesim_pkg:stable
```

For NVidia GPUs

```bash
rocker --nvidia --x11 --network host ghcr.io/thunderatz/travesim_pkg:stable
```

### 🐋 docker

```bash
docker run -it \
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

The container accepts two enviroment variables as running options:

- `GUI` - Whether to show TraveSim GUI or not, values can be 0 or 1, default is 1.
- `ROBOTS_PER_TEAM` - Numbers of robots per team, values can be 3 or 5, default is 3.

To pass enviroment variables to docker or rocker use the option `-e NAME[=VALUE]` or `--env NAME[=VALUE]`. For example, using rocker:

```bash
rocker --devices /dev/dri/card0 --x11 --network host -e GUI=0 -e ROBOTS_PER_TEAM=5 ghcr.io/thunderatz/travesim_pkg:stable
```
