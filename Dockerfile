## Setup general ROS stuff
# See: https://hub.docker.com/r/osrf/ros
# See: https://ros.org/reps/rep-0150.html

FROM osrf/ros:noetic-desktop-full-focal

# Used to access local X server
USER root

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

CMD . devel/setup.sh && roslaunch travesim_adapters adapters.launch
