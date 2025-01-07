#
# This builds a custom gnuradio container on alpine basis in two stages:
#
# First compile a stripped down gnuradio version, without GRC, intended
# to be run headless
#
# Then, build a container from that.
#

FROM alpine:3.21 AS build
WORKDIR /gnuradio
RUN apk add alpine-sdk doas

# Create a abuild group and user https://stackoverflow.com/a/49955098
RUN adduser --disabled-password abuild -G abuild
RUN addgroup abuild wheel
# Configure doas to be used by wheel users
COPY <<EOF /etc/doas.d/wheel_becomes_root.conf
permit nopass :wheel
EOF

RUN chown -R abuild:abuild /gnuradio
ADD . /gnuradio

USER abuild
RUN abuild-keygen -a -i -n
RUN abuild -r

# step image with installing custom gnuradio version
FROM alpine:3.21 AS alpine_gr
COPY --from=build /home/abuild/packages/x86_64/gnuradio-3.10.11.0-r2.apk /gnuradio_apks/
RUN apk add --allow-untrusted --no-cache /gnuradio_apks/gnuradio-3.10.11.0-r2.apk
RUN apk add --no-cache zeromq py3-pyzmq
