#!/bin/bash

# glibc 2.7をサポートしているNode.jsの最終バージョンは、Node.js v10系です。
mise ls-remote node | grep 10
mise use -g node@10
