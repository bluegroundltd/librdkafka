FROM --platform=linux/amd64 debian:bullseye-slim AS rdkafka-builder
RUN apt-get update && apt-get install -yqq \
    build-essential \
    git \
    libcurl4-openssl-dev \
    liblz4-dev \
    libsasl2-dev \
    libssl-dev \
    libtool-bin \
    libxml2-dev \
    libzstd-dev \
    pkg-config \
    python3 \
    rapidjson-dev \
    zlib1g-dev

# linking the libxml library where the librdkafka build script expects it
RUN ln -sf /usr/lib/x86_64-linux-gnu/pkgconfig/libxml-2.0.pc /usr/lib/x86_64-linux-gnu/pkgconfig/libxml2.pc

COPY . .

RUN ./configure && \
    make && \
    make install
