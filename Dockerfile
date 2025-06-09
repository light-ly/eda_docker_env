FROM centos:centos7.9.2009

# create user
RUN groupadd -g 1000 liuyi
RUN groupadd -g 1001 pub_group
RUN useradd -u 1000 -g 1000 -G ly -M -d /home/ly -s /bin/bash ly
RUN useradd -u 1001 -g 1001 -G pub_group -M -d /home/lfx -s /bin/bash lfx

# install dependency
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum update -y
RUN yum upgrade -y
RUN yum groupinstall -y 'Development Tools'
RUN yum install -y iproute vim epel-release systemd NetworkManager
RUN yum install -y tree xterm csh ksh java-1.8.0-openjdk glibc.i686
RUN yum install -y glibc elfutils-libelf motif libXp libpng libjpeg-turbo expat glibc-devel gdb redhat-lsb libXScrnSaver apr apr-util compat-db47 xorg-x11-server-Xvfb mesa-dri-drivers
RUN yum install -y xorg-x11-fonts-misc xorg-x11-fonts-ISO8859-1-75dpi
RUN yum install -y pulseaudio-libs pulseaudio-libs-glib2 numactl-libs
RUN yum install -y flex fontconfig freetype glib2 libICE libX11 libxcb libXext libXi libXrender libSM libxkbcommon-x11 libXt-devel libGLU-devel mesa-libOSMesa-devel mesa-libGL-devel mesa-libGLU-devel xcb-util-keysyms xcb-util-image xcb-util-wm xcb-util-renderutil

# maybe need copy env scripts
# COPY src dst

ENTRYPOINT ["/bin/bash"]

