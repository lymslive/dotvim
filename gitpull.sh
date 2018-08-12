#! /bin/bash
# 更新自己的 ~/.vim 配置，及 pack 目录下自己的插件

git pull

cd pack/lymslive/opt/autoplug
git pull

cd ../vimloo
git pull

cd ../vnote
git pull

