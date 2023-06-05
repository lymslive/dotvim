#!/bin/bash

# From: https://gist.github.com/leolord/bb51bdee3f199c2a6cfe2d57a42a2c26
# Complie vim from source with lua and python3 interface

# Remove previous installations
sudo apt-get remove vim vim-runtime vim-tiny vim-common

# Install dependencies
sudo apt-get install libncurses5-dev liblua5.3-dev lua5.3 python3-dev

# Fix liblua paths
# You have to compile luajit for yourself.
sudo ln -s /usr/include/lua5.3 /usr/include/lua
sudo ln -s /usr/lib/x86_64-linux-gnu/liblua5.3.so /usr/local/lib/liblua.so

# Clone vim sources
cd ~
git clone https://github.com/vim/vim.git

cd vim

# can also modify src/Makefile and run `make config && make`
# can install $Home
./configure \
	--enable-luainterp \
	--enable-python3interp \
	--with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu/ \
	--enable-cscope \
	--disable-netbeans \
	--enable-terminal \
	--disable-xsmp \
	--enable-fontset \
	--enable-multibyte \
	--enable-fail-if-missing \
	--with-compiledby=leolord \
	--with-modified-by=leolord

make VIMRUNTIMEDIR=/usr/share/vim/vim74

sudo apt-get install checkinstall
sudo checkinstall
