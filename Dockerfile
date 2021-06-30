## Setup general ROS stuff
# See: https://hub.docker.com/r/osrf/ros
# See: https://ros.org/reps/rep-0150.html

FROM osrf/ros:noetic-desktop-full-focal

# Used to access local X server
USER root

# Install sound dependecies
RUN apt-get update && apt-get install -y \
  pulseaudio \
  && rm -rf /var/lib/apt/lists/*

# Catkin related
ENV CATKIN_WS /root/catkin_ws/

RUN mkdir -p ${CATKIN_WS}/src/travesim
RUN mkdir -p ${CATKIN_WS}/src/travesim_adapters

WORKDIR ${CATKIN_WS}

# Initialize catkin workspace
RUN /ros_entrypoint.sh catkin_make

# Docker best practices: install dependencies before copying all source code
COPY travesim/package.xml src/${PROJECT_NAME}/travesim

COPY travesim_adapters/package.xml src/${PROJECT_NAME}/travesim_adapters

RUN . devel/setup.sh && \
    apt update --fix-missing && \
    rosdep install -y travesim travesim_adapters

COPY travesim src/travesim/
COPY travesim_adapters src/travesim_adapters/

# Compile any source code whitin the simulation
RUN /ros_entrypoint.sh catkin_make

RUN mkdir -m 700 /tmp/runtime
ENV XDG_RUNTIME_DIR=/tmp/runtime

# Expose adapters default ports
EXPOSE 10002
EXPOSE 20011
EXPOSE 20012
EXPOSE 20013

# User options
ENV GUI 1
ENV ROBOTS_PER_TEAM 3
ENV SOUND 0

CMD . devel/setup.sh && roslaunch travesim_adapters adapters.launch gui:=${GUI} robots_per_team:=${ROBOTS_PER_TEAM} sound:=${SOUND}
