from ghcr.io/astral-sh/uv:0.9.21 as uv_image
from python:3.11-slim-bookworm as builder
copy --from=uv_image /uv /usr/local/bin/uv

run apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

env PORT=8000
workdir /app

copy CONTRIBUTING.md LICENSE /app/

env UV_LINK_MODE=copy \
    UV_COMPILE_BYTECODE=1 \
    UV_PYTHON_DOWNLOADS=never \
    UV_SYSTEM_PYTHON=1 \
    UV_PROJECT_ENVIRONMENT=/usr/local

# Copy local version of the registry and install reqs
copy uv.lock pyproject.toml /app/

copy schemas /app/schemas
copy yard /app/yard
copy README.md /app/
# Needed to grab the VCS version from git tags
run --mount=type=bind,target=/app/.git,source=.git uv sync --all-extras --frozen

copy tasks.py /app/
# Regenerate models from the current schemas
run invoke regenerate-models

# Validate all entries against the schema
run invoke validate-entries

cmd uvicorn yard.app:app --host 0.0.0.0 --port ${PORT}

healthcheck --interval=5m --timeout=3s --start-period=10s \
  cmd curl --fail http://localhost:${PORT}/api || exit 1
