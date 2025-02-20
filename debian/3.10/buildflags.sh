#!/bin/bash

NEW_CMD="dh_auto_configure -- -DCMAKE_BUILD_TYPE=Release -DLIB_SUFFIX=\"/\$(DEB_HOST_MULTIARCH)\" \
    -DENABLE_CTRLPORT_THRIFT=ON     \
    -DENABLE_PYTHON=ON              \
    -DENABLE_GR_ZEROMQ=ON           \
    -DENABLE_GR_AUDIO=OFF           \
    -DENABLE_DOXYGEN=OFF            \
    -DENABLE_GRC=OFF                \
    -DENABLE_GR_QTGUI=OFF           \
    -DENABLE_GR_SOAPY=OFF           \
    -DENABLE_GR_UHD=OFF             \
    -DENABLE_GR_IIO=OFF             \
    -DENABLE_GR_MODTOOL=OFF         \
    -DENABLE_GR_BLOCKTOOL=OFF       \
    -DENABLE_GR_VIDEO_SDL=OFF"

ESCAPED_CMD=$(printf "%s\n" "\t$NEW_CMD" | sed 's/[&/\]/\\&/g')

sed -i "/^\s*dh_auto_configure --/c $ESCAPED_CMD" "debian/rules"
