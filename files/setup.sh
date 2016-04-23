#!/bin/bash
set -e

sleep 10

apt-get update -qq && apt-get install -y cowsay
cowsay "all setup!"
