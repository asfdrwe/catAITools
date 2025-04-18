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

result=`osascript -e 'display dialog "動画生成推奨モデルをダウンロードしますか？" with title "ダウンロード" with text buttons {"いいえ","はい"} default button 2'`

if [ "$result" = "button returned:はい" ]; then
  echo "hunyuan-video-t2v-720p-Q5_K_M.gguf"
  curl -L -# -o models/diffusion_models/hunyuan-video-t2v-720p-Q5_K_M.gguf 'https://huggingface.co/city96/HunyuanVideo-gguf/resolve/main/hunyuan-video-t2v-720p-Q5_K_M.gguf?download=true'
  echo "hunyuan-video-i2v-720p-Q5_K_M.gguf"
  curl -L -# -o models/diffusion_models/hunyuan-video-i2v-720p-Q5_K_M.gguf 'https://huggingface.co/city96/HunyuanVideo-I2V-gguf/resolve/main/hunyuan-video-i2v-720p-Q5_K_M.gguf?download=true'
  echo "hyvideo_FastVideo_LoRA-fp8.safetensors"
  curl -L -# -o models/loras/hyvideo_FastVideo_LoRA-fp8.safetensors 'https://huggingface.co/Kijai/HunyuanVideo_comfy/resolve/main/hyvideo_FastVideo_LoRA-fp8.safetensors?download=true'
  echo "clip_l.safetensors"
  curl -L -# -o models/clip/clip_l.safetensors 'https://huggingface.co/Comfy-Org/HunyuanVideo_repackaged/resolve/main/split_files/text_encoders/clip_l.safetensors?download=true'
  echo "llava_llama3_vision.safetensors"
  curl -L -# -o models/clip_vision/llava_llama3_vision.safetensors 'https://huggingface.co/Comfy-Org/HunyuanVideo_repackaged/resolve/main/split_files/clip_vision/llava_llama3_vision.safetensors?download=true'
  echo "llava-llama-3-8b-v1_1.Q4_K_M.gguf"
  curl -L -# -o models/clip/llava-llama-3-8b-v1_1.Q4_K_M.gguf 'https://huggingface.co/city96/llava-llama-3-8b-v1_1-imat-gguf/resolve/main/llava-llama-3-8B-v1_1-Q4_K_M.gguf?download=true'
  echo "hunyuan_video_vae_bf16.safetensors"
  curl -L -# -o models/vae/hunyuan_video_vae_bf16.safetensors 'https://huggingface.co/Comfy-Org/HunyuanVideo_repackaged/resolve/main/split_files/vae/hunyuan_video_vae_bf16.safetensors?download=true'

  echo "wan2.1-t2v-14b-Q4_K_M.gguf"
  curl -L -# -o models/diffusion_models/wan2.1-t2v-14b-Q4_K_M.gguf 'https://huggingface.co/city96/Wan2.1-T2V-14B-gguf/resolve/main/wan2.1-t2v-14b-Q4_K_M.gguf?download=true'
  echo "wan2.1-i2v-14b-480p-Q4_K_M.gguf"
  curl -L -# -o models/diffusion_models/wan2.1-i2v-14b-480p-Q4_K_M.gguf 'https://huggingface.co/city96/Wan2.1-I2V-14B-480P-gguf/resolve/main/wan2.1-i2v-14b-480p-Q4_K_M.gguf?download=true'
  echo "umt5-xxl-encoder-Q4_K_M.gguf"
  curl -L -# -o models/clip/umt5-xxl-encoder-Q4_K_M.gguf 'https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q4_K_M.gguf?download=true'
  echo "clip_vision_h.safetensors"
  curl -L -# -o models/clip_vision/clip_vision_h.safetensors 'https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/clip_vision/clip_vision_h.safetensors?download=true' 
  echo "wan_2.1_vae.safetensors"
  curl -L -# -o models/vae/wan_2.1_vae.safetensors 'https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors?download=true'

  mkdir models/mmaudio
  echo "apple_DFN5B-CLIP-ViT-H-14-384_fp16.safetensors"
  curl -L -# -o models/mmaudio/apple_DFN5B-CLIP-ViT-H-14-384_fp16.safetensors 'https://huggingface.co/Kijai/MMAudio_safetensors/resolve/main/apple_DFN5B-CLIP-ViT-H-14-384_fp16.safetensors?download=true'
  echo "mmaudio_large_44k_v2_fp16.safetensors"
  curl -L -# -o models/mmaudio/mmaudio_large_44k_v2_fp16.safetensors 'https://huggingface.co/Kijai/MMAudio_safetensors/resolve/main/mmaudio_large_44k_v2_fp16.safetensors?download=true'
  echo "mmaudio_synchformer_fp16.safetensors"
  curl -L -# -o models/mmaudio/mmaudio_synchformer_fp16.safetensors 'https://huggingface.co/Kijai/MMAudio_safetensors/resolve/main/mmaudio_synchformer_fp16.safetensors?download=true'
  echo "mmaudio_vae_44k_fp16.safetensors"
  curl -L -# -o models/mmaudio/mmaudio_vae_44k_fp16.safetensors 'https://huggingface.co/Kijai/MMAudio_safetensors/resolve/main/mmaudio_vae_44k_fp16.safetensors?download=true'
  osascript -e 'display dialog "動画生成推奨モデルのダウンロードが完了しました。" with title "完了通知" with text buttons {"OK"} with icon 1'
fi
