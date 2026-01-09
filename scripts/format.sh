#!/usr/bin/env bash
set -e

echo "Formatting shell scripts..."

find . -type f -name "*.sh" -exec sed -i 's/[ \t]*$//' {} \;

echo "Formatting completed."
