#!/bin/bash
# SPDX-FileCopyrightText: 2025 asfdrwe <asfdrwe@gmail.com>
# SPDX-License-Identifier: MIT

FOLDER_PATH=`osascript -e 'POSIX path of (choose folder with prompt "ComfyUIのフォルダを選択してください")'`
echo "${FOLDER_PATH}"
cd "${FOLDER_PATH}"

if [ ! -d .venv/ ]; then
  osascript -e 'display dialog "ComfyUIのフォルダではありません。" buttons {"終了"} with icon 2 with title "エラー" '
  exit
fi

result=`osascript -e 'display dialog "Wan2.1 1.3B InP動画生成モデルをダウンロードしますか？" with title "ダウンロード" with text buttons {"いいえ","はい"} default button 2'`

if [ "$result" = "button returned:はい" ]; then
  echo "wan2.1-1.3b-InP.safetensors"
  curl -L -# -o models/diffusion_models/wan2.1-1.3b-InP.safetensors 'https://huggingface.co/alibaba-pai/Wan2.1-Fun-V1.1-1.3B-InP/resolve/main/diffusion_pytorch_model.safetensors?download=true'
  echo "wan.inp_vae.pth"
  curl -L -# -o models/vae/wan.inp_vae.pth 'https://huggingface.co/alibaba-pai/Wan2.1-Fun-V1.1-1.3B-InP/resolve/main/Wan2.1_VAE.pth?download=true'


  osascript -e 'display dialog "Wan2.1 1.3B InP動画生成モデルのダウンロードが完了しました。" with title "完了通知" with text buttons {"OK"} with icon 1'
fi
