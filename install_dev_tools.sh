#!/bin/bash

set -e  # зупиняти виконання при помилці

echo "🔧 Перевірка та встановлення інструментів розробки..."

# Docker
if ! command -v docker &> /dev/null; then
  echo "🔧 Встановлення Docker..."
  sudo apt update
  sudo apt install -y docker.io
  sudo systemctl start docker
  sudo systemctl enable docker
  echo "✅ Docker встановлено."
else
  echo "✅ Docker уже встановлено."
fi

# Docker Compose
if ! command -v docker-compose &> /dev/null; then
  echo "🔧 Встановлення Docker Compose..."
  sudo apt update
  sudo apt install -y docker-compose
  echo "✅ Docker Compose встановлено."
else
  echo "✅ Docker Compose уже встановлено."
fi

# Python 3.9+
PYTHON_VERSION=$(python3 -V 2>&1 | awk '{print $2}')
REQUIRED_VERSION="3.9"

if dpkg --compare-versions "$PYTHON_VERSION" ge "$REQUIRED_VERSION"; then
  echo "✅ Python $PYTHON_VERSION уже встановлено."
else
  echo "🔧 Встановлення Python..."
  sudo apt update
  sudo apt install -y python3 python3-pip python3-venv
  echo "✅ Python встановлено."
fi

# Django
if ! python3 -m django --version &> /dev/null; then
  echo "🔧 Встановлення Django..."
  pip3 install Django --break-system-packages
  echo "✅ Django встановлено."
else
  echo "✅ Django уже встановлено."
fi

echo "🎉 Усі інструменти встановлені або вже були встановлені!"