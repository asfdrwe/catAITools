#!/bin/bash
# SPDX-FileCopyrightText: 2025 asfdrwe <asfdrwe@gmail.com>
# SPDX-License-Identifier: MIT

LLAMACPPURL="https://github.com/ggml-org/llama.cpp/releases/download/b5143/llama-b5143-bin-macos-arm64.zip"

# to the script folder
cd `dirname $0`

# llama.cpp in the script folder
if [ ! -d build ]; then
  echo "llamacpp NOT INSTALLED"
  curl -# -o llama.zip -L "${LLAMACPPURL}"
  unzip llama.zip
#  rm -f llama.zip
fi

# select model file using Apple Script(osascript)
MODELFILE=`osascript -e 'POSIX path of (choose file with prompt "モデルファイルを選択して下さい")'`

# run llama-server
exec ./build/bin/llama-server -m "${MODELFILE}"
