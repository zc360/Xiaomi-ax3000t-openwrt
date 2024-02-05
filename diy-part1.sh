#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

#删除不必要的包解决磁盘不足
- name: Initialization environment
  env:
    DEBIAN_FRONTEND: noninteractive
  run: |
    docker rmi `docker images -q`
    sudo rm -rf /etc/apt/sources.list.d/* /usr/share/dotnet /usr/local/lib/android /opt/ghc /etc/mysql /etc/php
    sudo -E apt-get -y purge azure-cli* docker* ghc* zulu* hhvm* llvm* firefox* google* dotnet* aspnetcore* powershell* openjdk* adoptopenjdk* mysql* php* mongodb* moby* snap* || true
    sudo -E apt-get -qq update
    sudo -E apt-get -qq install libfuse-dev $(curl -fsSL git.io/depends-ubuntu-2204)
    sudo -E apt-get -qq autoremove --purge
    sudo -E apt-get -qq clean
    sudo timedatectl set-timezone "$TZ"
    sudo mkdir -p /workdir
    sudo chown $USER:$GROUPS /workdir
