FROM centos:7

# Update the base system
RUN yum -y update \
 && yum install -y centos-release-scl epel-release \
 && yum -y update \
 && yum clean all

# Install build tools
RUN yum -y install ccache cmake3 gcc gcc-c++ make ninja-build wget \
 && yum clean all

# Install dependencies
RUN yum -y install fontconfig libxcb-devel libxkbcommon-x11-devel mesa-libGL-devel xcb-util-image xcb-util-keysyms xcb-util-wm zlib-devel \
 && yum clean all

# Install ICU
RUN mkdir /icu && cd /icu \
 && wget https://github.com/unicode-org/icu/releases/download/release-56-2/icu4c-56_2-src.tgz \
 && tar xf icu4c-56_2-src.tgz \
 && ls && cd icu \
 && ./source/runConfigureICU Linux \
 && make -j \
 && make install \
 && cd / && rm -r /icu 

# Install devtoolset-8 and git
RUN yum -y install devtoolset-8-toolchain rh-git218 \
 && yum clean all

# Add linuxdeployqt
ADD linuxdeployqt /root/linuxdeployqt
