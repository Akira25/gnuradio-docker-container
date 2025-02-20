# step image with installing custom gnuradio version
FROM debian:12 AS build_deb

ARG GR_VERSION="3.10.11.0"
ARG PKG_RELEASE="2"

LABEL org.opencontainers.image.source=https://github.com/Akira25/gnuradio-docker-container
LABEL org.opencontainers.image.description="A minimal (headless) GNU Radio, packed into an alpine docker container"
LABEL org.opencontainers.image.licenses=MIT

RUN apt update && apt install build-essential wget cmake debhelper dh-make devscripts -y
RUN apt install -y \
    dh-python\
    doxygen\
    gir1.2-gtk-3.0\
    gir1.2-pango-1.0\
    graphviz\
    libad9361-dev\
    libasound2-dev\
    libboost-date-time-dev\
    libboost-dev\
    libboost-program-options-dev\
    libboost-regex-dev\
    libboost-system-dev\
    libboost-test-dev\
    libboost-thread-dev\
    libcodec2-dev\
    libcppunit-dev\
    libfftw3-dev\
    libfontconfig-dev\
    libgmp-dev\
    libgsl-dev\
    libgsm1-dev\
    libiio-dev\
    libjack-jackd2-dev\
    libjs-mathjax\
    libpulse-dev\
    libqt5core5a\
    libqt5opengl5-dev\
    libqt5svg5-dev\
    libqwt-qt5-dev\
    libsdl1.2-dev\
    libsndfile1-dev\
    libsoapysdr-dev\
    libthrift-dev\
    libuhd-dev\
    libunwind-dev\
    libusb-1.0-0-dev\
    libvolk2-dev\
    libxi-dev\
    libxrender-dev\
    cppzmq-dev\
    ninja-build\
    pkg-config\
    portaudio19-dev\
    pybind11-dev\
    python3-click\
    python3-click-plugins\
    python3-dev\
    python3-gi\
    python3-gi-cairo\
    python3-jsonschema\
    python3-lxml\
    python3-mako\
    python3-numpy\
    python3-opengl\
    python3-packaging\
    python3-pyqt5\
    python3-schema\
    python3-scipy\
    python3-thrift\
    python3-yaml\
    python3-zmq\
    qt5-qmake\
    qtbase5-dev\
    qttools5-dev\
    libspdlog-dev\
    thrift-compiler\
    xmlto\
    xvfb

WORKDIR /build/
RUN wget http://deb.debian.org/debian/pool/main/g/gnuradio/gnuradio_$GR_VERSION.orig.tar.gz
RUN wget http://deb.debian.org/debian/pool/main/g/gnuradio/gnuradio_$GR_VERSION-$PKG_RELEASE.debian.tar.xz
RUN tar xf gnuradio_$GR_VERSION.orig.tar.gz
WORKDIR /build/gnuradio-$GR_VERSION
RUN tar xf ../gnuradio_$GR_VERSION-$PKG_RELEASE.debian.tar.xz

# disable unneeded modules
#RUN NEW_CMD="$(cat << 'EOF'
#dh_auto_configure -- -DCMAKE_BUILD_TYPE=Release -DLIB_SUFFIX="/$(DEB_HOST_MULTIARCH)" \
#                -DENABLE_CTRLPORT_THRIFT=ON     \
#                -DENABLE_PYTHON=ON              \
#                -DENABLE_GR_ZEROMQ=ON           \
#                -DENABLE_GR_AUDIO=OFF           \
#                -DENABLE_DOXYGEN=OFF            \
#                -DENABLE_GRC=OFF                \
#                -DENABLE_GR_QTGUI=OFF           \
#                -DENABLE_GR_SOAPY=OFF           \
#                -DENABLE_GR_UHD=OFF             \
#                -DENABLE_GR_IIO=OFF             \
#                -DENABLE_GR_MODTOOL=OFF         \
#                -DENABLE_GR_BLOCKTOOL=OFF       \
#                -DENABLE_GR_VIDEO_SDL=OFF
#EOF
#)" && \
#    ESCAPED_CMD=$(printf "%s\n" "$NEW_CMD" | sed 's/[&/\]/\\&/g') && \
#    sed -i "/^\s*dh_auto_configure --/c $ESCAPED_CMD" "debian/rules"

COPY buildflags.sh /usr/bin/buildflags.sh
RUN chmod +x /usr/bin/buildflags.sh && /usr/bin/buildflags.sh

RUN dpkg-buildpackage -us -uc
