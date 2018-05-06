#! /bin/env bash
# when enter this directory, use . .ex.sh to source this script

# cdup n
# goto up directory n levels
function cu()
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
function cg()
{
	if [[ $# < 1 ]]; then
		echo "$ cg packname"
		return
	fi

	local name=$1
	local path=$(cdgit.pl $name)
	if [[ -n $path ]]; then
		cd $path
	fi
}

