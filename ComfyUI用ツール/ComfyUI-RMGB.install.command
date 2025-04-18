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
hash -r 

cd custom_nodes
git clone https://github.com/1038lab/ComfyUI-RMBG

cd ComfyUI-RMBG 

patch -p1 <<EOF
diff -uNr ComfyUI-RMBG.orig/requirements.txt ComfyUI-RMBG/requirements.txt
--- ComfyUI-RMBG.orig/requirements.txt	2025-04-11 23:05:30
+++ ComfyUI-RMBG/requirements.txt	2025-04-11 23:05:45
@@ -13,4 +13,3 @@
 opencv-python>=4.7.0
 scipy>=1.10.0
 onnxruntime>=1.15.0
-onnxruntime-gpu>=1.15.0
\ No newline at end of file
EOF

pip3 install -r requirements.txt

osascript -e 'display dialog "インストールが完了しました。" with title "完了通知" with text buttons {"OK"} with icon 1'

