# step image with installing custom gnuradio version
FROM debian:12 AS deb_test

LABEL org.opencontainers.image.source=https://github.com/Akira25/gnuradio-docker-container
LABEL org.opencontainers.image.description="A minimal (headless) GNU Radio, packed into an alpine docker container"
LABEL org.opencontainers.image.licenses=MIT

#COPY --from=build /home/abuild/packages/*/gnuradio-*.apk /gnuradio_apks/
#RUN apk add --allow-untrusted --no-cache /gnuradio_apks/gnuradio-*.apk
RUN apt update && apt install python3-zmq -y
