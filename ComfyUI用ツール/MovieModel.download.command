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

result=`osascript -e 'display dialog "動画生成推奨モデルをダウンロードしますか？" with title "ダウンロード" with text buttons {"いいえ","はい"} default button 2'`
if [ result = "はい" ]; then
    curl -L -# -o models/diffusion_models/hunyuan-video-t2v-720p-Q4_K_M.gguf 'https://huggingface.co/city96/HunyuanVideo-gguf/resolve/main/hunyuan-video-t2v-720p-Q4_K_M.gguf?download=true'
    curl -L -# -o models/loras/hyvideo_FastVideo_LoRA-fp8.safetensors 'https://huggingface.co/Kijai/HunyuanVideo_comfy/resolve/main/hyvideo_FastVideo_LoRA-fp8.safetensors?download=true'
    curl -L -# -o models/clip/clip_l.safetensors 'https://huggingface.co/Comfy-Org/HunyuanVideo_repackaged/resolve/main/split_files/text_encoders/clip_l.safetensors?download=true'
    curl -L -# -o models/clip_vision/llava_llama3_vision.safetensors 'https://huggingface.co/Comfy-Org/HunyuanVideo_repackaged/resolve/main/split_files/clip_vision/llava_llama3_vision.safetensors?download=true'
    curl -L -# -o models/text_encoders/llava-llama-3-8b-v1_1.Q4_K_M.gguf 'https://huggingface.co/city96/llava-llama-3-8b-v1_1-imat-gguf/resolve/main/llava-llama-3-8B-v1_1-Q4_K_M.gguf?download=true'
    curl -L -# -o models/vae/hunyuan_video_vae_bf16.safetensors 'https://huggingface.co/Comfy-Org/HunyuanVideo_repackaged/resolve/main/split_files/vae/hunyuan_video_vae_bf16.safetensors?download=true

    mkdir models/mmaudio
    curl -L -# -o models/mmaudio/apple_DFN5B-CLIP-ViT-H-14-384_fp16.safetensors 'https://huggingface.co/Kijai/MMAudio_safetensors/resolve/main/apple_DFN5B-CLIP-ViT-H-14-384_fp16.safetensors?download=true'
    curl -L -# -o models/mmaudio/mmaudio_large_44k_v2_fp16.safetensors 'https://huggingface.co/Kijai/MMAudio_safetensors/resolve/main/mmaudio_large_44k_v2_fp16.safetensors?download=true'
    curl -L -# -o models/mmaudio/mmaudio_synchformer_fp16.safetensors 'https://huggingface.co/Kijai/MMAudio_safetensors/resolve/main/mmaudio_synchformer_fp16.safetensors?download=true'
    curl -L -# -o models/mmaudio/mmaudio_vae_44k_fp16.safetensors 'https://huggingface.co/Kijai/MMAudio_safetensors/resolve/main/mmaudio_vae_44k_fp16.safetensors?download=true'
    
    osascript -e 'display dialog "動画生成推奨モデルのダウンロードが完了しました。" with title "完了通知" with text buttons {"OK"} with icon 1'
fi
