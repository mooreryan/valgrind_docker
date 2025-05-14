build_image:
    #!/usr/bin/env bash
    set -euxo pipefail

    docker buildx create --use

    docker buildx build \
        --platform linux/amd64,linux/arm64 \
        -t valgrind \
        --output=type=docker .

run_image args:
    #!/usr/bin/env bash
    set -euxo pipefail

    docker run --rm --platform=linux/amd64 valgrind {{ args }}
