FROM debian:bookworm

LABEL description="Docker image for running valgrind"

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    build-essential \
    valgrind \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["valgrind"]
CMD ["--help"]
