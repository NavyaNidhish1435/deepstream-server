FROM nvcr.io/nvidia/deepstream:6.4-samples-multiarch

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    python3 python3-pip nano git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/nvidia/deepstream/app

COPY configs ./configs
COPY scripts ./scripts
COPY models ./models

RUN chmod +x ./scripts/start.sh

CMD ["./scripts/start.sh"]
