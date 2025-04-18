#!/bin/bash
# SPDX-FileCopyrightText: 2025 asfdrwe <asfdrwe@gmail.com>
# SPDX-License-Identifier: MIT

# to the script folder
cd `dirname $0`

# require Xcode Command Line Tools for brew
xcode-select --install

# check homebrew & llama.cpp in the script folder
if [ ! -d llamacpp ]; then
  echo "llamacpp NOT INSTALLED"
  mkdir llamacpp
  curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip-components 1 -C llamacpp
  eval "$(llamacpp/bin/brew shellenv)"
  hash -r 
  brew update --force --quiet
  chmod -R go-w "$(brew --prefix)/share/zsh"
  brew install llama.cpp
  hash -r
else 
  eval "$(llamacpp/bin/brew shellenv)"
  hash -r
fi

# select model file using Apple Script(osascript)
MODELFILE=`osascript -e 'POSIX path of (choose file with prompt "モデルファイルを選択して下さい")'`

# run llama-server
exec llama-server -m "${MODELFILE}"
