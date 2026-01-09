#!/usr/bin/env bash
set -e

echo "DebForge diagnostic report"
echo "--------------------------"

command -v bash >/dev/null || echo "bash not found"
command -v dpkg-deb >/dev/null || echo "dpkg-deb not found"

echo "Architecture: $(uname -m)"
echo "Working directory: $(pwd)"
