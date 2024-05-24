#!/bin/sh

set -ex pipefail

# Build script for Cloudflare pages

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt install racket -y

raco pkg install scripty

./make.rkt
