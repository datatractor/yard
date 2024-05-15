from python:3.11-slim-buster

run apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

env PORT=8000
workdir /app

copy CONTRIBUTING.md LICENSE /app/

# Copy local version of the registry and install reqs
copy pyproject.toml /app

copy schemas /app/schemas
copy yard /app/yard
copy README.md /app/

# Needed to grab the VCS version from git tags
run --mount=type=bind,target=/app/.git,source=.git pip install .
copy tasks.py /app

# Regenerate models from the current schemas
run invoke regenerate-models

# Validate all entries against the schema
run invoke validate-entries

cmd uvicorn yard.app:app --host 0.0.0.0 --port ${PORT}

healthcheck --interval=5m --timeout=3s --start-period=10s \
  cmd curl --fail http://localhost:${PORT}/api || exit 1
