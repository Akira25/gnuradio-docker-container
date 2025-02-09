# Final image
FROM akira25/gnuradio-docker-container:latest

# uncomment for different demonstrations
COPY ./flowgraphs/demo_send_binaural_beat.py /app/flowgraph.py
#COPY flowgraphs/nfm_reiceiver.py /app/flowgraph.py

CMD ["/app/flowgraph.py"]
