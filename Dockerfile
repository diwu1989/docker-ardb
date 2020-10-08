FROM ubuntu:18.04

# Build stage:
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y file git make gcc g++ automake autoconf libbz2-dev libz-dev wget liblz4-dev

RUN git clone --depth 1 https://github.com/yinqiwen/ardb.git && \
    storage_engine=rocksdb make -C ardb

# Production stage:
FROM ubuntu:18.04

COPY ardb.conf       /etc/
COPY --from=0 ardb/src/ardb-server /usr/bin
COPY entrypoint.sh /entrypoint.sh

WORKDIR /var/lib/ardb

EXPOSE 16379
CMD /entrypoint.sh
