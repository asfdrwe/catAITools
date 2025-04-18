#!/bin/bash
# SPDX-FileCopyrightText: 2025 asfdrwe <asfdrwe@gmail.com>
# SPDX-License-Identifier: MIT

FOLDER_PATH=`osascript -e 'POSIX path of (choose folder with prompt "ComfyUIのフォルダを選択してください")'`
echo ${FOLDER_PATH}
cd "${FOLDER_PATH}"

if [ ! -d .venv/ ]; then
   osascript -e 'display dialog "ComfyUIのフォルダではありません。" buttons {"終了"} with icon 2 with title "エラー" '
   exit
fi

result=`osascript -e 'display dialog "音楽生成推奨モデルをダウンロードしますか？" with title "ダウンロード" with text buttons {"いいえ","はい"} default button 2'`
if [ result = "はい" ]; then
    curl -L -# -o models/checkpoints/stable-audio-open-1.0.safetensors 'https://huggingface.co/audo/stable-audio-open-1.0/resolve/main/model.safetensors?download=true'
    curl -L -# -o models/checkpoints/stable-audio-open-1.0-Music.safetensors 'https://huggingface.co/Nekochu/stable-audio-open-1.0-Music/resolve/main/model.safetensors?download=true'
    curl -L -# -o models/clip/t5_base.safetensors 'https://huggingface.co/google-t5/t5-base/resolve/main/model.safetensors?download=true'
    
    osascript -e 'display dialog "音楽生成推奨モデルのダウンロードが完了しました。" with title "完了通知" with text buttons {"OK"} with icon 1'
fi
