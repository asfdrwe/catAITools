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

result=`osascript -e 'display dialog "画像生成推奨モデルをダウンロードしますか？" with title "ダウンロード" with text buttons {"いいえ","はい"} default button 2'`

if [ "$result" = "button returned:はい" ]; then
  echo "Illustrious-XL-v1.1.safetensors"
  curl -L -# -o models/checkpoints/Illustrious-XL-v1.1.safetensors 'https://huggingface.co/OnomaAIResearch/Illustrious-XL-v1.1/resolve/main/Illustrious-XL-v1.1.safetensors?download=true'
  echo "fuduki_mix_v20.safetensors"
  curl -L -# -o models/checkpoints/fuduki_mix_v20.safetensors 'https://huggingface.co/Kotajiro/fuduki_mix/resolve/main/fuduki_mix_v20.safetensors?download=true'
  echo "dmd2_sdxl_4step_lora_fp16.safetensors"
  curl -L -# -o models/loras/dmd2_sdxl_4step_lora_fp16.safetensors 'https://huggingface.co/tianweiy/DMD2/resolve/main/dmd2_sdxl_4step_lora_fp16.safetensors?download=true'
  echo "4x-UltraSharp.safetensors"
  curl -L -# -o models/upscale_models/4x-UltraSharp.safetensors 'https://huggingface.co/Kim2091/UltraSharp/resolve/main/4x-UltraSharp.safetensors?download=true'
  echo "CN-anytest_v4-marged.safetensors"
  curl -L -# -o models/controlnet/CN-anytest_v4-marged.safetensors 'https://huggingface.co/2vXpSwA7/iroiro-lora/resolve/main/test_controlnet2/CN-anytest_v4-marged.safetensors?download=true'
    
  osascript -e 'display dialog "画像生成推奨モデルのダウンロードが完了しました。" with title "完了通知" with text buttons {"OK"} with icon 1'
fi
