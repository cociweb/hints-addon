#!/usr/bin/env bash
python3 -m hints \
    --proto 'tcp://0.0.0.0:10300' \
    --model-dir /model \
    --data-dir /data "$@"
