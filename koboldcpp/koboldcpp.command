#!/bin/bash
# SPDX-FileCopyrightText: 2025 asfdrwe <asfdrwe@gmail.com>
# SPDX-License-Identifier: MIT

KOBOLDCPPURL="https://github.com/LostRuins/koboldcpp/releases/download/v1.87.4/koboldcpp-mac-arm64"

# to the script folder
cd `dirname $0`

# check install

if [ ! -d koboldcpp ]; then
  osascript -e 'display dialog "koboldcppがインストールされていません。\nプログラムをダウンロードしますか？" with title "ダウンロード" with text buttons {"キャンセル","はい"} default button 2'
  mkdir  koboldcpp
  curl -o koboldcpp/koboldcpp-mac-arm64 -L "${KOBOLDCPPURL}"
  xattr -rc koboldcpp/koboldcpp-mac-arm64
  chmod +x koboldcpp/koboldcpp-mac-arm64
  osascript -e 'display dialog "koboldcppのダウンロードが完了しました。" with title "完了通知" with text buttons {"OK"} with icon 1'
fi

if [ ! -d models ]; then
  result=`osascript -e 'display dialog "推奨モデルが指定フォルダにダウンロードされていません。\nダウンロードしますか？" with title "ダウンロード" with text buttons {"いいえ","はい"} default button 2'`
  if [ result = "はい" ]; then
    mkdir models
    curl -L -# -o models/cyberagent-DeepSeek-R1-Distill-Qwen-14B-Japanese-Q4_K_M.gguf 'https://huggingface.co/mmnga/cyberagent-DeepSeek-R1-Distill-Qwen-14B-Japanese-gguf/resolve/main/cyberagent-DeepSeek-R1-Distill-Qwen-14B-Japanese-Q4_K_M.gguf?download=true'
    curl -L -# -o models/Qwen2.5-VL-7B-Instruct-q5_k_m.gguf 'https://huggingface.co/Mungert/Qwen2.5-VL-7B-Instruct-GGUF/resolve/main/Qwen2.5-VL-7B-Instruct-q5_k_m.gguf?download=true'
    curl -L -# -o models/Qwen2.5-VL-7B-Instruct-mmproj-f16.gguf 'https://huggingface.co/Mungert/Qwen2.5-VL-7B-Instruct-GGUF/resolve/main/Qwen2.5-VL-7B-Instruct-mmproj-f16.gguf?download=true'
    osascript -e 'display dialog "推奨モデルのダウンロードが完了しました。" with title "完了通知" with text buttons {"OK"} with icon 1'
  fi
fi

# run koboldcpp
echo "koboldcppを起動します。"
exec koboldcpp/koboldcpp-mac-arm64
