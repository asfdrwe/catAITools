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

. .venv/bin/activate

cd custom_nodes
git clone https://github.com/Flow-two/ComfyUI-WanStartEndFramesNative
cd ComfyUI-WanStartEndFramesNative

patch -p3 <<EOF
diff -uNr ComfyUI.orig/custom_nodes/ComfyUI-WanStartEndFramesNative/nodes/nodes.py ComfyUI/custom_nodes/ComfyUI-WanStartEndFramesNative/nodes/nodes.py
--- ComfyUI.orig/custom_nodes/ComfyUI-WanStartEndFramesNative/nodes/nodes.py	2025-04-12 21:58:16
+++ ComfyUI/custom_nodes/ComfyUI-WanStartEndFramesNative/nodes/nodes.py	2025-04-13 22:23:59
@@ -68,8 +68,8 @@
         return {"required": {"positive": ("CONDITIONING", ),
                              "negative": ("CONDITIONING", ),
                              "vae": ("VAE", ),
-                             "width": ("INT", {"default": 832, "min": 320, "max": nodes.MAX_RESOLUTION, "step": 16}),
-                             "height": ("INT", {"default": 480, "min": 320, "max": nodes.MAX_RESOLUTION, "step": 16}),
+                             "width": ("INT", {"default": 832, "min": 240, "max": nodes.MAX_RESOLUTION, "step": 16}),
+                             "height": ("INT", {"default": 480, "min": 240, "max": nodes.MAX_RESOLUTION, "step": 16}),
                              "length": ("INT", {"default": 81, "min": 1, "max": 1000, "step": 4}),
                              "start_image": ("IMAGE", ),
                 },
EOF

osascript -e 'display dialog "インストールが完了しました。" with title "完了通知" with text buttons {"OK"} with icon 1'
