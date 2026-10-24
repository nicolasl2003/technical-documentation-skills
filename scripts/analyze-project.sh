#!/usr/bin/env bash
# Quick project summary to feed the documentation

echo "=== Directory tree (3 levels) ==="
find . -maxdepth 3 \
  -not -path '*/node_modules*' -not -path '*/.git/*' \
  -not -path '*/dist/*' -not -path '*/__pycache__*' -not -path '*/.venv/*' \
  | sort | head -100

echo -e "\n=== Detected manifests ==="
ls package.json pyproject.toml requirements.txt go.mod Cargo.toml \
   pom.xml build.gradle composer.json Gemfile 2>/dev/null

echo -e "\n=== Infra / CI ==="
ls Dockerfile docker-compose*.yml Makefile .github/workflows/* \
   .gitlab-ci.yml 2>/dev/null

echo -e "\n=== Environment files ==="
ls .env.example .env.sample 2>/dev/null

echo -e "\n=== Existing documentation ==="
ls README* docs/ docs/adr/ 2>/dev/null

echo -e "\n=== Languages (file count) ==="
find . -type f -not -path '*/node_modules*' -not -path '*/.git/*' \
  | sed -n 's/.*\.\([a-zA-Z0-9]*\)$/\1/p' | sort | uniq -c | sort -rn | head -8