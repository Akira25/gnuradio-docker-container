FROM alpine:3.21 AS build
WORKDIR /gnuradio
RUN apk add alpine-sdk doas

# Create a abuild group and user https://stackoverflow.com/a/49955098
RUN adduser --disabled-password abuild -G abuild

COPY APKBUILD /gnuradio
COPY fix-test-numpy2.patch /gnuradio

USER abuild
# RUN abuild-keygen -a -i -n
RUN abuild-keygen -a -n
RUN abuild -r

#FROM alpine:3.21
#
#RUN apk add --no-cache gnuradio zeromq py3-pyzmq
#
#COPY /zmq_fm_transceiver.py /app/fm_receiver.py
##COPY --from=build /bin/hello /bin/hello
#
#CMD /app/fm_receiver.py
