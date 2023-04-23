#!/bin/bash
# 用 source 加载本脚本的函数，或添加到 .bashrc 中初始化
# 然后可用两个快捷 cd 命令
# cdm 在构建子目录与源码子目录之间互相切换
# cdn 转到项目目录(上溯含 build 的父目录)
#
# tanshuil / 2023-04-17

function cdm() {
  # 获取当前目录的绝对路径
  current_dir=$(pwd)

  # 如果当前目录在构建目录下
  if [[ $current_dir == */build/* ]]; then
    # 获取项目根目录的路径
    project_dir=${current_dir%/build*}

    # 源码目录为构建目录去掉 /build/ 中间部分
    build_dir="$(pwd)"
    src_dir="${build_dir/build\//}"

    # 如果源码目录存在，则跳转到源码目录
    if [[ -d $src_dir ]]; then
      cd $src_dir
    else
      echo "Error: source directory not found."
      return 1
    fi

  # 如果当前目录在源码目录下
  else
    # 初始化项目根目录为空
    project_dir=

    # 上溯各级父目录，查找第一个包含 build 目录的目录
    dir=$current_dir
    while [[ $dir != "/" && -z $project_dir ]]; do
      dir=$(dirname $dir)
      if [[ -d "$dir/build" ]]; then
        project_dir=$dir
      fi
    done

    # 如果未找到包含 build 目录的目录，则返回错误
    if [[ -z $project_dir ]]; then
      echo "Error: project root directory not found."
      return 1
    fi

    # 构建目录为源码目录去掉项目根目录后，加上 /build/
    build_dir=${current_dir/$project_dir\//$project_dir\/build\/}

    # 如果构建目录存在，则跳转到构建目录
    if [[ -d $build_dir ]]; then
        cd $build_dir
    else
        echo "Error: build directory not found."
    fi

  fi
}

function cdn() {
  # 初始化项目根目录为空
  project_dir=

  # 上溯各级父目录，查找第一个包含 build 目录的目录
  dir=$(pwd)
  while [[ $dir != "/" && -z $project_dir ]]; do
    dir=$(dirname $dir)
    if [[ -d "$dir/build" ]]; then
        project_dir=$dir
    fi
  done

  # 如果项目目录存在，则跳转到项目目录
  if [[ -d $project_dir ]]; then
    cd $project_dir
  else
    echo "Error: project directory not found."
  fi
}
