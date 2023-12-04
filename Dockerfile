# Base image - Set default to CUDA 11.8.0
ARG CUDA_VERSION=12.1.0

# Use different base images based on CUDA_VERSION argument
FROM runpod/base:0.4.2-cuda${CUDA_VERSION} as builder

ENV HF_DATASETS_CACHE="/runpod-volume/huggingface-cache/datasets" \
    HUGGINGFACE_HUB_CACHE="/runpod-volume/huggingface-cache/hub" \
    TRANSFORMERS_CACHE="/runpod-volume/huggingface-cache/hub"

# Install Python dependencies (Worker Template)
COPY builder/requirements.txt /requirements.txt
RUN --mount=type=cache,target=/root/.cache/pip \
    python3.11 -m pip install --upgrade pip && \
    python3.11 -m pip install --upgrade -r /requirements.txt --no-cache-dir && \
    rm /requirements.txt

# Add source files
ADD src .

ARG MODEL_NAME=""
ARG MODEL_BASE_PATH="/runpod-volume/"
ARG HF_TOKEN=""
ARG QUANTIZATION=""

RUN if [ -n "$QUANTIZATION" ]; then \
        export QUANTIZATION=$QUANTIZATION; \
    fi

# Start the handler
CMD ["python3.11", "/handler.py"]
