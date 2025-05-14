build_local:
    #!/usr/bin/env bash
    set -euxo pipefail

    docker buildx create --use

    docker buildx build \
        --platform linux/amd64,linux/arm64 \
        -t valgrind:latest \
        --output=type=docker .

push_image username:
    #!/usr/bin/env bash
    set -euxo pipefail

    docker buildx create --use

    docker buildx build \
        --platform linux/amd64,linux/arm64 \
        -t {{ username }}/valgrind:latest \
        --push .

run_image args:
    #!/usr/bin/env bash
    set -euxo pipefail

    docker run --rm --platform=linux/amd64 valgrind {{ args }}
