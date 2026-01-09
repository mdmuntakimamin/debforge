#!/usr/bin/env bash
set -e

echo "Running shell syntax checks..."

find . -type f -name "*.sh" -exec bash -n {} \;

echo "Lint completed successfully."
