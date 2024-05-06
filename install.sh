#!/bin/bash

installRunner (){
    install_runner_arm() {
      OS_NAME="$(uname -s)"
      if [ "$OS_NAME" = "Linux" ]; then
        curl --silent --location "https://github.com/deployment-io/runner/releases/latest/download/gin-gonic-server_linux_arm64.tar.gz" | tar xz -C /tmp
      elif [ "$OS_NAME" = "Darwin" ]; then
        curl --silent --location "https://github.com/deployment-io/runner/releases/latest/download/gin-gonic-server_darwin_arm64.tar.gz" | tar xz -C /tmp
      else
        echo "Unsupported OS: $OS_NAME"
        return
      fi
      sudo mkdir -p /usr/local/bin && sudo mv /tmp/runner /usr/local/bin/gin-gonic-server
    }

    install_runner_amd() {
        OS_NAME="$(uname -s)"
        if [ "$OS_NAME" = "Linux" ]; then
          curl --silent --location "https://github.com/deployment-io/runner/releases/latest/download/gin-gonic-server_linux_amd64.tar.gz" | tar xz -C /tmp
        elif [ "$OS_NAME" = "Darwin" ]; then
          curl --silent --location "https://github.com/deployment-io/runner/releases/latest/download/gin-gonic-server_darwin_amd64.tar.gz" | tar xz -C /tmp
        else
          echo "Unsupported OS: $OS_NAME"
          return
        fi
        sudo mkdir -p /usr/local/bin && sudo mv /tmp/gin-gonic-server /usr/local/bin/gin-gonic-server
    }

    ARCH=$(uname -m)
    if [ "$ARCH" = "x86_64" ]; then
      install_runner_amd
    elif [ "$ARCH" = "aarch64" ]; then
      install_runner_arm
    else
      echo "Unsupported architecture: $ARCH"
      return
    fi
}

installRunner

if command -v gin-gonic-server &> /dev/null; then
    gin-gonic-server example
    rm install.sh
fi