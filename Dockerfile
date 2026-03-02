
FROM ubuntu:24.04

RUN apt-get update -qq && \
    apt-get install -y wget tar && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN wget -q https://github.com/seaweedfs/seaweedfs/releases/download/4.07/linux_amd64_large_disk.tar.gz && \
    tar -xzf linux_amd64_large_disk.tar.gz && \
    rm linux_amd64_large_disk.tar.gz

# We use -volume.index=memory
# This keeps the index (database) in RAM and only writes file chunks to the NFS mount.
ENTRYPOINT ["./weed", "mini", "-dir=/weed-data", "-volume.index=memory"]

EXPOSE 9333 9340 8888 8333 7333 23646
