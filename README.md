# GNU Radio in a container

This repository holds a proof of concept of packaging gnuradio flowgraphs into alpine linux docker container.

## Architectural goals

What I want to achieve with this is, to run flowgraphs seamlessly, is their dependencies are included into the container already. This might come in handy on the longterm.

The Flowgraphs to be included into such a container should contain ZMQ-Blocks for their input and output. I.e. like this:

![Example flowgraph with ZMQ-Blocks for their input and output](flowgraph.png)

Scenarios which I consider this useful:

- Decouple your GNU Radio application from the underlying OS and its GNU Radio version
- Combine blocks from different GNU Radio versions
- Spawn different flowgraphs in your transmission pipeline easily, i.e. for a GNU Radio based transceiver, working in different modes

## Limitations

I expect the containers to be run in the host network. This means, that you should not use the docker networking feature, but hang the containers directly into the host, as if there were merely processes.

To circumvent complicate redirections with i.e. audio devices, I expect flowgraphs using ZMQ-Blocks, which control Audio and Hardware and so on, to be run directly on the Host system, without a docker container.

## Demonstration

To test this out on your personal computer, you may follow the steps in this section. I personally use podman as container runtime, but you should be able to run these commands with docker perfectly, by just replacing `podman` with the `docker` command:

```sh
# Build the container from Dockerfile
$ podman build .
# Start the docker container in the host network
$ podman run --network=host 59f3c95578b3  # substitue this with the ID of your image
# Start the host-part of the flowgraph handling the audio:
$ ./receiver.py
```

You may also start the `receiver`-flowgraph from your gnuradio companion. By running this setup, you should be able to hear a binaural beat on 440 Hz. The signal is generated within the flowgraph and send via the zmq sockets to the host part.

## Further Notes

This is a proof of concept, which can be improved further. At the time of writing, an alpine image with GNU Radio in it takes around 780 MB. I expect this to be heavily improved, when dropping some stuff from the custom compiled GNU Radio. For example, one might drop audio support, as this will not be used anyway in this concept.
