#!/bin/zsh

# Search for package installation entries in the APT history logs
(zgrep -h "Commandline: apt install" /var/log/apt/history.log* 2>/dev/null; zcat /var/log/apt/history.log.*.gz 2>/dev/null) |
grep -oP "apt install \K\S+" |
sort -u
