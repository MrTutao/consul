#!/bin/bash

set -euo pipefail

# wait for bootstrap to apply config entries
retry_default read_config_entry service-resolver s2 >/dev/null
retry_default read_config_entry service-resolver s3 >/dev/null

docker_wget http://localhost:8500/v1/internal/discovery-chain/s2 -q -O -

retry_default gen_envoy_bootstrap s1 19000
retry_default gen_envoy_bootstrap s2 19001    # unused
retry_default gen_envoy_bootstrap s3 19002    # unused
retry_default gen_envoy_bootstrap s3-v1 19003 # unused
retry_default gen_envoy_bootstrap s3-v2 19004

export REQUIRED_SERVICES="
s1 s1-sidecar-proxy
s2 s2-sidecar-proxy
s3 s3-sidecar-proxy
s3-v1 s3-v1-sidecar-proxy
s3-v2 s3-v2-sidecar-proxy
"
