#!/bin/bash
# 设置环境变量，确保使用UTF-8编码
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
opkg remove smartdns
cd /etc/smartdns-ipk
opkg install /etc/smartdns-ipk/1.ipk
sleep 1s
opkg install /etc/smartdns-ipk/2.ipk
sleep 1s
opkg install /etc/smartdns-ipk/3.ipk
sleep 1s
opkg install /etc/smartdns-ipk/4.ipk
sleep 1s
echo "smartdns 安装完成"