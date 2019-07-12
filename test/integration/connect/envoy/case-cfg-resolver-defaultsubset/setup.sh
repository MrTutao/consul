#!/bin/bash

set -euo pipefail

# we create s2 anyway to show it's NOT used
retry_default gen_envoy_bootstrap s1 19000
retry_default gen_envoy_bootstrap s2 19001
retry_default gen_envoy_bootstrap s2-v1 19002
retry_default gen_envoy_bootstrap s2-v2 19003

export REQUIRED_SERVICES="s1 s1-sidecar-proxy s2 s2-sidecar-proxy s2-v1 s2-v1-sidecar-proxy s2-v2 s2-v2-sidecar-proxy"
