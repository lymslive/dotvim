#! /bin/env bash
# when enter this directory, use . .ex.sh to source this script

# cdup n
# goto up directory n levels
function cdup()
{
	if [[ $# == 0 ]]; then
		cd ..
		return
	fi

	local up
	for (( i = 0; $i < $1; i++ )); do
		up=../$up
	done;

	cd $up
}

# find a vim-plugin pack under ~/.vim/pack, and cd to that directory
function cdpack()
{
	if [[ $# < 1 ]]; then
		echo "$ cdpack packname"
		return
	fi

	local root=$(pwd)
	local pack=$1
	local path=$(find $root/pack -name "*$pack*" -type d -print -quit)
	if [[ -n $path ]]; then
		cd $path
	fi
}

